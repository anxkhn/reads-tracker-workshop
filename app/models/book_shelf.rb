class BookShelf < ApplicationRecord
  belongs_to :book
  belongs_to :shelf

  validates :book_id, uniqueness: { scope: :shelf_id }
end