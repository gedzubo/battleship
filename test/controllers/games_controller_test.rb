require "test_helper"

class GamesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @other = users(:two)
    @game = games(:in_progress_game)
  end

  # Authentication guards

  test "index redirects unauthenticated requests" do
    get games_path
    assert_redirected_to new_session_path
  end

  test "show redirects unauthenticated requests" do
    get game_path(@game)
    assert_redirected_to new_session_path
  end

  test "create redirects unauthenticated requests" do
    post games_path, params: { opponent_id: @other.id }
    assert_redirected_to new_session_path
  end

  test "destroy redirects unauthenticated requests" do
    delete game_path(@game)
    assert_redirected_to new_session_path
  end

  # index

  test "index returns success" do
    sign_in_as(@user)
    get games_path
    assert_response :success
  end

  test "index lists games where current user is challenger or opponent" do
    sign_in_as(@user)
    get games_path
    assert_select "li", minimum: 1
  end

  # show

  test "show returns success for a participant" do
    sign_in_as(@user)
    get game_path(@game)
    assert_response :success
  end

  # create

  test "create makes a new invited game and redirects to it" do
    sign_in_as(@user)
    assert_difference "Game.count", 1 do
      post games_path, params: { opponent_id: @other.id }
    end
    new_game = Game.order(created_at: :desc).first
    assert_redirected_to game_path(new_game)
    assert new_game.invited?
    assert_equal @user, new_game.challenger
    assert_equal @other, new_game.opponent
  end

  # update

  test "update changes status and redirects to the game" do
    sign_in_as(@user)
    patch game_path(@game), params: { game: { status: "finished" } }
    assert_redirected_to game_path(@game)
    assert @game.reload.finished?
  end

  # destroy

  test "destroy soft-deletes the game and redirects to index" do
    sign_in_as(@user)
    delete game_path(@game)
    assert_redirected_to games_path
    assert @game.reload.deleted?
  end
end
