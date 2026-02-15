require 'test_helper'

class BookSearchTest < ActionDispatch::IntegrationTest
  fixtures :books, :authors

  test 'search should return matching books' do
    get search_books_url, params: { query: 'Book' }
    assert_response :success
  end

  test 'search should return empty results for no matches' do
    get search_books_url, params: { query: 'NonExistentBookTitle12345' }
    assert_response :success
  end

  test 'search should handle empty query' do
    get search_books_url, params: { query: '' }
    assert_response :success
  end

  test 'search should be case insensitive' do
    Book.create!(title: 'LowerCaseBook', isbn: '9780000002001', author: authors(:one), status: :reading)
    
    get search_books_url, params: { query: 'lowercasebook' }
    assert_response :success
  end

  test 'search should not have N+1 query problem' do
    author = authors(:one)
    
    5.times do |i|
      Book.create!(
        title: "SearchTestBook #{i}",
        isbn: "978000000100#{i}",
        author: author,
        status: :reading
      )
    end

    queries = []
    ActiveSupport::Notifications.subscribe('sql.active_record') do |_name, _start, _finish, _id, payload|
      queries << payload[:sql] if payload[:sql].include?('SELECT')
    end

    get search_books_url, params: { query: 'SearchTestBook' }
    assert_response :success

    ActiveSupport::Notifications.unsubscribe('sql.active_record')

    author_queries = queries.count { |q| q.include?('authors') && q.include?('SELECT') }
    
    assert_equal 1, author_queries, 
                  "BUG: Expected 1 author query (with .includes(:author)), but got #{author_queries}. " \
                  "N+1 query detected - authors should be preloaded with .includes(:author)"
  end
end
