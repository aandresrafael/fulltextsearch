class Document < ActiveRecord::Base
  include Search
  has_many :tokens

  def self.searchable_fields
    %w(content)
  end
end
