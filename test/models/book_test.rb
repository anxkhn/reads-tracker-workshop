require 'test_helper'

class BookTest < ActiveSupport::TestCase
  fixtures :books, :authors, :reviews

  test 'should have associations' do
    book = books(:one)
    assert_respond_to book, :author
    assert_respond_to book, :reviews
    assert_respond_to book, :shelves
    assert_respond_to book, :reading_sessions
  end

  test 'should belong to author' do
    book = books(:one)
    assert_equal authors(:one), book.author
  end

  test 'should have many reviews' do
    book = books(:one)
    assert book.reviews.count >= 1
  end

  test 'should validate author presence' do
    book = Book.new(title: 'Test Book', isbn: '9780000000999')
    assert_not book.valid?
    assert_includes book.errors[:author], 'must exist'
  end

  test 'should validate unique isbn' do
    book = Book.new(title: 'Duplicate ISBN', isbn: books(:one).isbn, author: authors(:one))
    assert_not book.valid?
    assert_includes book.errors[:isbn], 'has already been taken'
  end

  test 'should allow blank isbn' do
    book = Book.new(title: 'No ISBN', isbn: nil, author: authors(:one))
    assert book.valid?
  end

  test 'should validate description length' do
    book = Book.new(title: 'Long Desc', description: 'x' * 2001, author: authors(:one))
    assert_not book.valid?
    assert_includes book.errors[:description], 'is too long (maximum is 2000 characters)'
  end

  test 'should have status enum' do
    book = books(:one)
    assert_respond_to book, :reading?
    assert_respond_to book, :want_to_read?
    assert_respond_to book, :completed?
  end

  test 'should calculate average rating' do
    book = books(:one)
    expected_average = (5 + 3) / 2.0
    assert_equal expected_average.round(2), book.average_rating
  end

  test 'should return 0 for average rating when no reviews' do
    book = Book.create!(title: 'No Reviews', author: authors(:one))
    assert_equal 0, book.average_rating
  end

  test 'should count total reviews' do
    book = books(:one)
    assert_equal 2, book.total_reviews
  end

  test 'should have by_status scope' do
    reading_books = Book.by_status('reading')
    assert_includes reading_books, books(:one)
  end

  test 'should have recent scope' do
    books = Book.recent
    assert_equal Book.order(created_at: :desc).to_a, books.to_a
  end

  test 'should destroy dependent reviews' do
    book = books(:one)
    review_count = book.reviews.count
    assert_difference 'Review.count', -review_count do
      book.destroy
    end
  end
end
