class CreateNotebooks < ActiveRecord::Migration
  def change
    create_table :notebooks do |t|
      t.string :guid
      t.string :name
      t.timestamp :en_created_at
      t.timestamp :en_updated_at
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
