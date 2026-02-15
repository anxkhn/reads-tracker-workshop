class BooksController < ApplicationController
  before_action :require_login, except: %i[index show search]
  before_action :set_book, only: %i[show edit update destroy]

  def index
    @books = Book.all.order(created_at: :desc).limit(10).offset(params[:page].to_i * 10)
    @books_count = Book.count
  end

  def show
    @review = @book.reviews.new
    @reviews = @book.reviews.order(created_at: :desc)
  end

  def new
    @book = Book.new
    @authors = Author.all
  end

  def create
    @book = Book.new(book_params)

    if @book.save
      redirect_to @book, notice: 'Book was successfully created.'
    else
      @authors = Author.all
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @authors = Author.all
  end

  def update
    if @book.update(book_params)
      redirect_to @book, notice: 'Book was successfully updated.'
    else
      @authors = Author.all
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @book.destroy!
    redirect_to books_url, notice: 'Book was successfully destroyed.'
  end

  def search
    if params[:query].present?
      if params[:advanced] == 'true'
        @books = advanced_search(params[:query])
      else
        @books = Book.where('title LIKE ? OR isbn LIKE ?', "%#{params[:query]}%", "%#{params[:query]}%")
      end
    else
      @books = Book.none
    end
  end

  private

  def set_book
    @book = Book.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:title, :author_id, :isbn, :description, :cover_url, :status)
  end

  def advanced_search(query)
    Book.find_by_sql("SELECT * FROM books WHERE title LIKE '%#{query}%' OR description LIKE '%#{query}%'")
  end
end