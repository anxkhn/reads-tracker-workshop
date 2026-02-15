class User < ApplicationRecord
  has_secure_password

  has_many :reviews, dependent: :destroy
  has_many :shelves, dependent: :destroy
  has_many :reading_sessions, dependent: :destroy

  validates :email, presence: true, uniqueness: true
  validates :name, presence: true
  validates :password, length: { minimum: 6 }, allow_nil: true

  def completed_books
    Book.joins(:reviews).where(reviews: { user_id: id, books: { status: :completed } })
  end

  def reading_stats
    {
      total_books: reviews.distinct.count(:book_id),
      total_pages: reading_sessions.sum(:pages_read),
      total_minutes: reading_sessions.sum(:duration_minutes)
    }
  end
end