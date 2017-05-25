require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(email: "email@email.com", username: "username", password: "password", password_confirmation: "password")
  end

  test "User is valid" do
    assert @user.valid?, true
  end

end
