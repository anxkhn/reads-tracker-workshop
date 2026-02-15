class CreateBooks < ActiveRecord::Migration[8.1]
  def change
    create_table :books do |t|
      t.string :title
      t.string :isbn
      t.text :description
      t.string :cover_url
      t.integer :status
      t.references :author, null: true, foreign_key: true

      t.timestamps
    end
  end
end
