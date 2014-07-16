require 'test_helper'

class UserTest < ActiveSupport::TestCase
  should have_many(:user_friendships)
  should have_many(:friends)

    test "a user should enter a first name" do
    user = User.new
    assert !user.save
    assert !user.errors[:first_name].empty?
  end

  test "a user should enter a last name" do
    user = User.new
    assert !user.save
    assert !user.errors[:last_name].empty?
  end

  test "a user should enter a profile name" do
    user = User.new
    assert !user.save
    assert !user.errors[:profile_name].empty?
  end

  test "a user should have a unique profile name" do
    user = User.new
    user.profile_name = users(:james).profile_name
    
    assert !user.save
    assert !user.errors[:profile_name].empty?
  end

  test "a user should have a profile name without spaces" do
  	user = User.new(first_name: 'James', last_name: 'Peach', email: 'j@peach.com')
  	user.profile_name = 'Mike the Frog'
  	user.password = user.password_confirmation = 'wordpass'

    assert !user.save
    assert !user.errors[:profile_name].empty?
    assert user.errors[:profile_name].include?("Must be formatted correctly.")
  end

  test "a user can have a correctly formatted profile name" do
  	user = User.new(first_name: 'James', last_name: 'Peach', email: 'j@peach.com')
  	user.password = user.password_confirmation = 'wordpass'

    user.profile_name = 'jpeach'
    assert user.valid?
  end

  test "that no error is raised when trying to access a friend list" do
      assert_nothing_raised do
      users(:james).friends
    end
  end

  test "that creating friendships on a user works" do
      users(:james).friends << users(:frankie)
      users(:james).friends.reload
      assert users(:james).friends.include?(users(:frankie))
    end
end

  


