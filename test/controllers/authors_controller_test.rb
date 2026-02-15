require 'test_helper'

class AuthorsControllerTest < ActionDispatch::IntegrationTest
  fixtures :authors, :books, :users

  setup do
    @user = users(:one)
  end

  test 'should get index' do
    get authors_url
    assert_response :success
  end

  test 'should get show' do
    get author_url(authors(:one))
    assert_response :success
  end

  test 'should get new' do
    sign_in(@user)
    get new_author_url
    assert_response :success
  end

  test 'should create author' do
    sign_in(@user)
    assert_difference 'Author.count', 1 do
      post authors_url, params: {
        author: {
          name: 'New Author',
          bio: 'A new author biography'
        }
      }
    end
    assert_redirected_to author_url(Author.last)
  end

  test 'should not create author without name' do
    sign_in(@user)
    assert_no_difference 'Author.count' do
      post authors_url, params: {
        author: {
          name: nil,
          bio: 'Bio without name'
        }
      }
    end
    assert_response :unprocessable_content
  end

  test 'should get edit' do
    sign_in(@user)
    get edit_author_url(authors(:one))
    assert_response :success
  end

  test 'should update author' do
    sign_in(@user)
    author = authors(:one)
    patch author_url(author), params: {
      author: {
        name: 'Updated Author Name'
      }
    }
    assert_redirected_to author_url(author)
    author.reload
    assert_equal 'Updated Author Name', author.name
  end

  test 'should not update author with invalid data' do
    sign_in(@user)
    author = authors(:one)
    patch author_url(author), params: {
      author: {
        name: nil
      }
    }
    assert_response :unprocessable_content
  end

  test 'should show author books' do
    get author_url(authors(:one))
    assert_response :success
  end
end
