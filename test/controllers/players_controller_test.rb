require 'test_helper'

class PlayersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get players_index_url
    assert_response :success
  end

  test "should get view" do
    get players_view_url
    assert_response :success
  end

end
