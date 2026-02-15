require 'test_helper'

class AuthorTest < ActiveSupport::TestCase
  fixtures :authors, :books

  test 'should have many books' do
    author = authors(:one)
    assert_respond_to author, :books
  end

  test 'should validate name presence' do
    author = Author.new(name: nil)
    assert_not author.valid?
    assert_includes author.errors[:name], "can't be blank"
  end

  test 'should be valid with name' do
    author = Author.new(name: 'Valid Author')
    assert author.valid?
  end

  test 'should allow blank bio' do
    author = Author.new(name: 'No Bio Author', bio: nil)
    assert author.valid?
  end

  test 'should have with_books scope' do
    assert_respond_to Author, :with_books
  end

  test 'with_books scope should include books' do
    authors = Author.with_books
    assert authors.first.association(:books).loaded? if authors.any?
  end

  test 'should nullify books on destroy' do
    author = authors(:one)
    book_ids = author.book_ids
    author.destroy
    book_ids.each do |book_id|
      assert_nil Book.find(book_id).author_id
    end
  end

  test 'should count books' do
    author = authors(:one)
    assert_equal 2, author.books.count
  end
end
