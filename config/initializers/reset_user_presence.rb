Rails.application.config.after_initialize do
  User.update_all(last_seen_at: nil)
end
