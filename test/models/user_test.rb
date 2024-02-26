require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "should not save user without email" do
    user = User.new(password: 'Complex@1234')
    assert_not user.save, "Saved the user without an email"
  end

  test "should not save user with invalid email format" do
    user = User.new(email: 'invalid_email', password: 'Complex@1234')
    assert_not user.save, "Saved the user with an invalid email format"
  end

  test "should not save user with short password" do
    user = User.new(email: 'test@example.com', password: 'Short1!')
    assert_not user.save, "Saved the user with a short password"
  end

  test "should not save user with password that doesn't meet complexity requirements" do
    user = User.new(email: 'test@example.com', password: 'alllowercase1')
    assert_not user.save, "Saved the user with a password that doesn't meet complexity requirements"
  end

  test "should save valid user" do
    user = User.new(email: 'test@example.com', password: 'Complex@1234')
    assert user.save, "Didn't save the user with valid attributes"
  end

  test "email should be unique" do
    user1 = users(:one) # assuming you have a users fixture
    user2 = User.new(email: user1.email, password: 'Complex@1234')
    assert_not user2.save, "Saved a user with a duplicate email"
  end
end
