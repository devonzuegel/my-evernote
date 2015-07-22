class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.string :guid
      t.string :title
      t.text :content
      t.timestamp :en_created_at
      t.timestamp :en_updated_at
      t.boolean :active
      t.string :notebook_guid
      t.string :author
      t.references :notebook, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
