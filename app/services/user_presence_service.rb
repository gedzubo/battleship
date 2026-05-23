class UserPresenceService
  def self.mark_online(user)
    was_online = user.online?
    user.update_columns(last_seen_at: Time.current)
    broadcast(user) unless was_online
  end

  def self.mark_offline(user)
    was_online = user.online?
    user.update_columns(last_seen_at: nil)
    broadcast(user) if was_online
  end

  # Called by heartbeat — keeps last_seen_at fresh and cleans up stale users.
  def self.touch(user)
    was_online = user.online?
    user.update_columns(last_seen_at: Time.current)
    broadcast(user) unless was_online
    broadcast_stale_users
  end

  def self.broadcast(user)
    Turbo::StreamsChannel.broadcast_replace_to(
      "players",
      target: ActionView::RecordIdentifier.dom_id(user, :presence),
      partial: "players/player_presence",
      locals: { player: user }
    )
  end
  private_class_method :broadcast

  def self.broadcast_stale_users
    User.where.not(last_seen_at: nil)
        .where("last_seen_at < ?", User::ONLINE_THRESHOLD.ago)
        .find_each do |user|
      user.update_columns(last_seen_at: nil)
      broadcast(user)
    end
  end
  private_class_method :broadcast_stale_users
end
