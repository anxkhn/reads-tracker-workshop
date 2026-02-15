require 'test_helper'

class UserFlowTest < ActionDispatch::IntegrationTest
  fixtures :users, :books, :authors, :shelves

  setup do
    @user = users(:one)
  end

  test 'user can view all books' do
    get books_url
    assert_response :success
    assert_select 'title', /Reads Tracker/i
  end

  test 'user can view book details' do
    book = books(:one)
    get book_url(book)
    assert_response :success
  end

  test 'user can view author details' do
    author = authors(:one)
    get author_url(author)
    assert_response :success
  end

  test 'user can create new book' do
    sign_in(@user)
    get new_book_url
    assert_response :success

    post books_url, params: {
      book: {
        title: 'Integration Test Book',
        isbn: '9780000000999',
        description: 'Created during integration test',
        author_id: authors(:one).id,
        status: 'want_to_read'
      }
    }
    assert_redirected_to book_url(Book.last)
    follow_redirect!
    assert_response :success
  end

  test 'user can update existing book' do
    sign_in(@user)
    book = books(:one)
    get edit_book_url(book)
    assert_response :success

    patch book_url(book), params: {
      book: {
        title: 'Updated Integration Book'
      }
    }
    assert_redirected_to book_url(book)
    book.reload
    assert_equal 'Updated Integration Book', book.title
  end

  test 'user can delete book' do
    sign_in(@user)
    book = Book.create!(title: 'To Delete', author: authors(:one))

    delete book_url(book)
    assert_redirected_to books_url
    assert_raises(ActiveRecord::RecordNotFound) do
      Book.find(book.id)
    end
  end

  test 'user can view authors list' do
    get authors_url
    assert_response :success
  end

  test 'user can create new author' do
    sign_in(@user)
    get new_author_url
    assert_response :success

    post authors_url, params: {
      author: {
        name: 'New Integration Author',
        bio: 'Author created during integration test'
      }
    }
    assert_redirected_to author_url(Author.last)
  end

  test 'user can view shelves' do
    sign_in(@user)
    get shelves_url
    assert_response :success
  end

  test 'navigation flow from index to book to author' do
    get books_url
    assert_response :success

    book = books(:one)
    get book_url(book)
    assert_response :success

    get author_url(book.author)
    assert_response :success
  end
end
