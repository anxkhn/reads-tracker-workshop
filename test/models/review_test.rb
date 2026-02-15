require 'test_helper'

class ReviewTest < ActiveSupport::TestCase
  fixtures :reviews, :users, :books

  test 'should belong to user' do
    review = reviews(:one)
    assert_equal users(:one), review.user
  end

  test 'should belong to book' do
    review = reviews(:one)
    assert_equal books(:one), review.book
  end

  test 'should validate rating presence' do
    review = Review.new(content: 'Great book content here')
    assert_not review.valid?
    assert_includes review.errors[:rating], "can't be blank"
  end

  test 'should validate rating inclusion' do
    review = Review.new(rating: 6, content: 'Content here', user: users(:one), book: books(:two))
    assert_not review.valid?
    assert_includes review.errors[:rating], 'is not included in the list'
  end

  test 'should accept valid ratings' do
    (1..5).each do |rating|
      review = Review.new(
        rating: rating,
        content: 'Valid rating content',
        user: users(:one),
        book: Book.create!(title: "Book #{rating}", author: authors(:one))
      )
      assert review.valid?, "Rating #{rating} should be valid"
    end
  end

  test 'should validate content presence' do
    review = Review.new(rating: 5, user: users(:one), book: books(:one))
    assert_not review.valid?
    assert_includes review.errors[:content], "can't be blank"
  end

  test 'should validate content minimum length' do
    review = Review.new(rating: 5, content: 'Short', user: users(:one), book: books(:two))
    assert_not review.valid?
    assert_includes review.errors[:content], 'is too short (minimum is 10 characters)'
  end

  test 'should validate content maximum length' do
    review = Review.new(
      rating: 5,
      content: 'x' * 5001,
      user: users(:one),
      book: books(:two)
    )
    assert_not review.valid?
    assert_includes review.errors[:content], 'is too long (maximum is 5000 characters)'
  end

  test 'should validate user uniqueness per book' do
    duplicate = Review.new(
      rating: 4,
      content: 'Another review from same user',
      user: users(:one),
      book: books(:one)
    )
    assert_not duplicate.valid?
    assert_includes duplicate.errors[:user_id], 'has already reviewed this book'
  end

  test 'should allow different users to review same book' do
    review = Review.new(
      rating: 4,
      content: 'Different user review',
      user: users(:two),
      book: books(:it)
    )
    assert review.valid?
  end

  test 'should be valid with all attributes' do
    review = Review.new(
      rating: 5,
      content: 'A valid review with enough characters',
      user: users(:two),
      book: books(:two)
    )
    assert review.valid?
  end
end
