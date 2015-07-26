class CreateNotebooks < ActiveRecord::Migration
  def change
    create_table :notebooks do |t|
      t.string :guid, null: false
      t.string :name
      t.timestamp :en_created_at
      t.timestamp :en_updated_at
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end

    add_index :notebooks, :guid, unique: true
  end
end
