class ReadingSession < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates :pages_read, presence: true, numericality: { greater_than: 0 }
  validates :duration_minutes, presence: true, numericality: { greater_than: 0 }
  validates :date, presence: true

  scope :for_user, ->(user) { where(user: user) }
  scope :for_book, ->(book) { where(book: book) }
  scope :by_date, -> { order(date: :desc) }
end