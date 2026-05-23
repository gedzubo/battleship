require "test_helper"

class PlayersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @other = users(:two)
  end

  test "redirects unauthenticated requests" do
    get players_path
    assert_redirected_to new_session_path
  end

  test "index returns success when authenticated" do
    sign_in_as(@user)
    get players_path
    assert_response :success
  end

  test "index lists other players but not the current user" do
    sign_in_as(@user)
    get players_path
    assert_select "li", text: /#{@other.email_address}/
    assert_select "li", text: /#{@user.email_address}/, count: 0
  end
end
