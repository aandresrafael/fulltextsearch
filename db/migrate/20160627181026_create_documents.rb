class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.text :content, null: false
    end
  end
end
