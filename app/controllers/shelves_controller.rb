class ShelvesController < ApplicationController
  before_action :require_login
  before_action :set_shelf, only: %i[show update destroy add_book remove_book]

  def index
    @shelves = current_user.shelves.includes(:books)
    @shelf = Shelf.new
  end

  def show
    @books = @shelf.books
  end

  def create
    @shelf = current_user.shelves.new(shelf_params)

    if @shelf.save
      redirect_to shelves_path, notice: 'Shelf was successfully created.'
    else
      @shelves = current_user.shelves.includes(:books)
      render :index, status: :unprocessable_entity
    end
  end

  def update
    if @shelf.update(shelf_params)
      redirect_to shelves_path, notice: 'Shelf was successfully updated.'
    else
      render :index, status: :unprocessable_entity
    end
  end

  def destroy
    @shelf.destroy!
    redirect_to shelves_path, notice: 'Shelf was successfully destroyed.'
  end

  def add_book
    book = Book.find(params[:book_id])
    @shelf.add_book(book)
    redirect_to @shelf, notice: 'Book added to shelf.'
  end

  def remove_book
    book = Book.find(params[:book_id])
    @shelf.remove_book(book)
    redirect_to @shelf, notice: 'Book removed from shelf.'
  end

  private

  def set_shelf
    @shelf = current_user.shelves.find_by(id: params[:id])
  end

  def shelf_params
    params.require(:shelf).permit(:name)
  end
end