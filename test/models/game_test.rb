require 'test_helper'

class GameTest < ActiveSupport::TestCase

  def setup
    @game = Game.create(name:"game_name", code: nil, owner_id:1)
    @user = User.create(username: "u", email:"U@u.com", password:"123456", password_confirmation:"123456")
  end

  test "game must have a name" do
    game = Game.create(code:nil, owner: @user)
    assert_equal game.valid?, false
  end

end
