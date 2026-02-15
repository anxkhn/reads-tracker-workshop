class ReviewsController < ApplicationController
  before_action :require_login
  before_action :set_review, only: %i[update destroy]
  before_action :authorize_review, only: %i[update destroy]

  def index
    @reviews = current_user.reviews.includes(:book).order(created_at: :desc)
  end

  def create
    @review = current_user.reviews.new(review_params)
    @book = Book.find(params[:book_id])
    @review.book = @book

    if @review.save
      if @book.completed?
        BookCompletionNotificationJob.perform_later(current_user.id, @book.id)
      end
      redirect_to @book, notice: 'Review was successfully created.'
    else
      @reviews = @book.reviews.order(created_at: :desc)
      render 'books/show', status: :ok
    end
  end

  def update
    if @review.update(params[:review])
      redirect_to @review.book, notice: 'Review was successfully updated.'
    else
      redirect_to @review.book, alert: 'Failed to update review.'
    end
  end

  def destroy
    book = @review.book
    @review.destroy!
    redirect_to book, notice: 'Review was successfully destroyed.'
  end

  private

  def set_review
    @review = Review.find(params[:id])
  end

  def authorize_review
    unless @review.user == current_user
      redirect_to books_path, alert: 'Not authorized'
    end
  end

  def review_params
    params.require(:review).permit(:rating, :content)
  end
end