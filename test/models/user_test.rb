require 'test_helper'

class UserTest < ActiveSupport::TestCase
  fixtures :users, :reviews, :shelves

  test 'should have secure password' do
    user = User.new(email: 'test@test.com', name: 'Test')
    user.password = 'password'
    assert user.authenticate('password')
    assert_not user.authenticate('wrong')
  end

  test 'should validate email presence' do
    user = User.new(name: 'Test', password: 'password')
    assert_not user.valid?
    assert_includes user.errors[:email], "can't be blank"
  end

  test 'should validate email uniqueness' do
    user = User.new(email: users(:one).email, name: 'Test', password: 'password')
    assert_not user.valid?
    assert_includes user.errors[:email], 'has already been taken'
  end

  test 'should validate name presence' do
    user = User.new(email: 'test@test.com', password: 'password')
    assert_not user.valid?
    assert_includes user.errors[:name], "can't be blank"
  end

  test 'should validate password minimum length' do
    user = User.new(email: 'test@test.com', name: 'Test', password: '12345')
    assert_not user.valid?
    assert_includes user.errors[:password], 'is too short (minimum is 6 characters)'
  end

  test 'should have many reviews' do
    user = users(:one)
    assert user.reviews.count >= 1
  end

  test 'should have many shelves' do
    user = users(:one)
    assert user.shelves.count >= 1
  end

  test 'should be valid with all required attributes' do
    user = User.new(
      email: 'valid@test.com',
      name: 'Valid User',
      password: 'password123'
    )
    assert user.valid?
  end
end
