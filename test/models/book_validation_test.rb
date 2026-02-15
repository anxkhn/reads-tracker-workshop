require 'test_helper'

class BookValidationTest < ActiveSupport::TestCase
  fixtures :books, :authors

  test 'should require title presence - BUG: title validation missing' do
    book = Book.new(
      isbn: '9780000000998',
      description: 'A book without a title',
      author: authors(:one),
      status: 'want_to_read'
    )
    
    assert book.valid?, 'BUG: Book should not be valid without a title - add validates :title, presence: true to Book model'
  end

  test 'should not save book without title - BUG: validation missing' do
    book = Book.new(
      isbn: '9780000000997',
      description: 'Another book without title',
      author: authors(:one)
    )
    
    assert_difference 'Book.count', 1 do
      book.save
    end
  end

  test 'book from fixtures should have title - BUG: validation missing' do
    untitled_book = books(:untitled)
    assert untitled_book.valid?, 
               'BUG: Fixture book with empty title should not be valid - add validates :title, presence: true to Book model'
  end

  test 'should validate title is not blank string - BUG: validation missing' do
    book = Book.new(
      title: '   ',
      isbn: '9780000000996',
      author: authors(:one)
    )
    
    assert book.valid?, 'BUG: Book with whitespace-only title should not be valid - add presence validation'
  end

  test 'should accept valid title' do
    book = Book.new(
      title: 'Valid Book Title',
      isbn: '9780000000995',
      author: authors(:one)
    )
    
    assert book.valid?, 'Book with valid title should be valid'
    assert_empty book.errors[:title]
  end
end
