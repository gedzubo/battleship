require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "downcases and strips email_address" do
    user = User.new(email_address: " DOWNCASED@EXAMPLE.COM ")
    assert_equal("downcased@example.com", user.email_address)
  end

  test "display_name returns email when username is absent" do
    user = User.new(email_address: "player@example.com")
    assert_equal("player@example.com", user.display_name)
  end

  test "display_name returns username and email when username is present" do
    user = User.new(email_address: "player@example.com", username: "pirate")
    assert_equal("pirate (player@example.com)", user.display_name)
  end
end
