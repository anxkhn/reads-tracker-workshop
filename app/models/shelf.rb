class Shelf < ApplicationRecord
  belongs_to :user
  has_many :book_shelves, dependent: :destroy
  has_many :books, through: :book_shelves

  validates :name, presence: true, uniqueness: { scope: :user_id }

  def add_book(book)
    books << book
  end

  def remove_book(book)
    book_shelves.find_by(book_id: book.id)&.destroy
  end
end