class DashboardController < ApplicationController
  before_action :require_login

  def index
    @stats = current_user.reading_stats
    @recent_sessions = current_user.reading_sessions.includes(:book).order(date: :desc).limit(5)
    @total_books = Book.count
    @total_authors = Author.count
    @total_reviews = Review.count
    @books_by_status = Book.group(:status).count
  end
end