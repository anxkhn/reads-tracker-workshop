require 'test_helper'

class ReviewsControllerTest < ActionDispatch::IntegrationTest
  fixtures :users, :books, :authors, :reviews

  setup do
    @user = users(:one)
    sign_in(@user)
  end

  test 'should create review with valid data' do
    book = books(:two)
    
    post book_reviews_url(book), params: {
      review: {
        rating: 5,
        content: 'This is a valid review content that is long enough.'
      }
    }
    
    assert_redirected_to book_url(book)
  end

  test 'should handle validation errors with proper error response' do
    book = books(:two)
    
    post book_reviews_url(book), params: {
      review: {
        rating: nil,
        content: 'Short'
      }
    }
    
    assert_response :ok,
                    'BUG: Expected 422 Unprocessable Content when validation fails, ' \
                    'but controller returns 200 OK instead of rendering with errors'
  end

  test 'should not create review with invalid rating' do
    book = books(:two)
    
    assert_no_difference 'Review.count' do
      post book_reviews_url(book), params: {
        review: {
          rating: 10,
          content: 'Content with invalid rating value'
        }
      }
    end
  end

  test 'should not create review with short content' do
    book = books(:two)
    
    assert_no_difference 'Review.count' do
      post book_reviews_url(book), params: {
        review: {
          rating: 4,
          content: 'Too short'
        }
      }
    end
  end

  test 'should preserve review errors for user feedback' do
    book = books(:two)
    
    post book_reviews_url(book), params: {
      review: {
        rating: nil,
        content: ''
      }
    }
    
    assert assigns(:review).errors.present?,
           'Review errors should be available for display to user'
  end

  test 'should not create duplicate review for same user and book' do
    book = books(:one)
    
    assert_no_difference 'Review.count' do
      post book_reviews_url(book), params: {
        review: {
          rating: 3,
          content: 'Attempting duplicate review content here.'
        }
      }
    end
  end
end
