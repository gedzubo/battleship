require "test_helper"

class UserPresenceServiceTest < ActiveSupport::TestCase
  setup do
    @user = users(:one)
    @user.update_columns(last_seen_at: nil)
  end

  test "mark_online sets last_seen_at" do
    UserPresenceService.mark_online(@user)
    assert @user.reload.online?
  end

  test "mark_offline clears last_seen_at" do
    @user.update_columns(last_seen_at: Time.current)
    UserPresenceService.mark_offline(@user)
    assert_nil @user.reload.last_seen_at
  end

  test "mark_online broadcasts when user was offline" do
    assert_broadcasts "players", 1 do
      UserPresenceService.mark_online(@user)
    end
  end

  test "mark_online does not broadcast when user was already online" do
    @user.update_columns(last_seen_at: Time.current)
    assert_broadcasts "players", 0 do
      UserPresenceService.mark_online(@user)
    end
  end

  test "mark_offline broadcasts when user was online" do
    @user.update_columns(last_seen_at: Time.current)
    assert_broadcasts "players", 1 do
      UserPresenceService.mark_offline(@user)
    end
  end

  test "touch sets last_seen_at and broadcasts stale users offline" do
    other = users(:two)
    other.update_columns(last_seen_at: 2.minutes.ago)

    assert_broadcasts "players", 2 do
      UserPresenceService.touch(@user) # broadcasts @user online + other offline
    end

    assert_nil other.reload.last_seen_at
  end
end
