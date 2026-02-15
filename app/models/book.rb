class Book < ApplicationRecord
  belongs_to :author

  has_many :reviews, dependent: :destroy
  has_many :book_shelves, dependent: :destroy
  has_many :shelves, through: :book_shelves
  has_many :reading_sessions, dependent: :destroy

  enum :status, { reading: 0, want_to_read: 1, completed: 2 }

  validates :isbn, uniqueness: true, allow_blank: true
  validates :description, length: { maximum: 2000 }
  validates :author, presence: true

  scope :by_status, ->(status) { where(status: status) }
  scope :recent, -> { order(created_at: :desc) }

  def average_rating
    reviews.average(:rating)&.round(2) || 0
  end

  def total_reviews
    reviews.count
  end
end