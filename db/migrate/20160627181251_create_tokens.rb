class CreateTokens < ActiveRecord::Migration
  def change
    create_table :tokens do |t|
      t.string :object_name
      t.string :field_name
      t.string :value
      t.integer :object_id
    end
  end
end
