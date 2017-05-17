require 'test_helper'

class TeamRequestsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @team_request = team_requests(:one)
  end

  test "should get index" do
    get team_requests_url
    assert_response :success
  end

  test "should get new" do
    get new_team_request_url
    assert_response :success
  end

  test "should create team_request" do
    assert_difference('TeamRequest.count') do
      post team_requests_url, params: { team_request: { reciever_id: @team_request.reciever_id, sender_id: @team_request.sender_id, team_id: @team_request.team_id } }
    end

    assert_redirected_to team_request_url(TeamRequest.last)
  end

  test "should show team_request" do
    get team_request_url(@team_request)
    assert_response :success
  end

  test "should get edit" do
    get edit_team_request_url(@team_request)
    assert_response :success
  end

  test "should update team_request" do
    patch team_request_url(@team_request), params: { team_request: { reciever_id: @team_request.reciever_id, sender_id: @team_request.sender_id, team_id: @team_request.team_id } }
    assert_redirected_to team_request_url(@team_request)
  end

  test "should destroy team_request" do
    assert_difference('TeamRequest.count', -1) do
      delete team_request_url(@team_request)
    end

    assert_redirected_to team_requests_url
  end
end
