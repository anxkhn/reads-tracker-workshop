class CreateBookShelves < ActiveRecord::Migration[8.1]
  def change
    create_table :book_shelves do |t|
      t.references :book, null: false, foreign_key: true
      t.references :shelf, null: false, foreign_key: true

      t.timestamps
    end
  end
end
