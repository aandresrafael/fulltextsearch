module Search
  extend ActiveSupport::Concern
  include Parser

  included do
  	after_save :create_tokens
  end


  def create_tokens
    return unless self.class.try(:searchable_fields) || self.class.searchable_fields.empty?
    fields = self.class.searchable_fields
    object_name = self.class.name
    object_id = self.id

    fields.each do |field|
      field_text = self.send(field.to_s)
      tokens = Parser.parse_text(field_text)

      Token.transaction do
        rows = tokens.inject([]) do |memo, token|
          memo << "('#{object_name}', '#{field}', '#{token}', #{object_id})"
        end

         Token.connection.execute(%Q{INSERT INTO tokens (object_name, field_name, value, object_id) VALUES #{rows.join(", ")}})
      end
    end
  end

  class_methods do
    def search(query)
      tokens = Parser.parse_text(query)
      fields = self.searchable_fields
      object_ids = Token.where(object_name: self.to_s, field_name: fields, value: tokens).map(&:object_id).uniq
      self.where(id: object_ids).all
    end
  end
end