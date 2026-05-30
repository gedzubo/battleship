require "test_helper"

class GameTest < ActiveSupport::TestCase
  # Associations

  test "requires a challenger" do
    game = Game.new(opponent: users(:two), status: :invited)
    assert_not game.valid?
  end

  test "requires an opponent" do
    game = Game.new(challenger: users(:one), status: :invited)
    assert_not game.valid?
  end

  test "winner is optional" do
    game = games(:finished_game)
    game.winner = nil
    assert game.valid?
  end

  test "current_turn_user is optional" do
    game = games(:in_progress_game)
    game.current_turn_user = nil
    assert game.valid?
  end

  # Status

  test "default status is invited" do
    game = Game.new(challenger: users(:one), opponent: users(:two))
    assert game.invited?
  end

  test "in_progress? is true for an active game" do
    assert games(:in_progress_game).in_progress?
  end

  test "finished? is true for a completed game" do
    assert games(:finished_game).finished?
  end

  # History scope

  test "history includes in_progress games" do
    assert_includes Game.history, games(:in_progress_game)
  end

  test "history includes finished games" do
    assert_includes Game.history, games(:finished_game)
  end

  test "history excludes invited games" do
    assert_not_includes Game.history, games(:invited_game)
  end

  # Soft delete

  test "soft_delete sets deleted_at" do
    game = Game.create!(challenger: users(:one), opponent: users(:two))
    assert_nil game.deleted_at
    game.soft_delete
    assert_not_nil game.deleted_at
  end

  test "deleted? returns true after soft_delete" do
    game = Game.create!(challenger: users(:one), opponent: users(:two))
    game.soft_delete
    assert game.deleted?
  end

  test "soft-deleted games are excluded from default queries" do
    game = Game.create!(challenger: users(:one), opponent: users(:two))
    game.soft_delete
    assert_not Game.exists?(game.id)
  end

  test "soft-deleted games are accessible via unscoped" do
    game = Game.create!(challenger: users(:one), opponent: users(:two))
    game.soft_delete
    assert Game.unscoped.exists?(game.id)
  end
end
