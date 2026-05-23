require "test_helper"

class HomeControllerTest < ActionDispatch::IntegrationTest
  test "redirects unauthenticated user to login" do
    get root_path
    assert_redirected_to new_session_path
  end

  test "renders home page for authenticated user" do
    sign_in_as(User.take)
    get root_path
    assert_response :success
  end
end
