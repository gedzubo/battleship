Rails.application.config.after_initialize do
  next if Rails.env.test?

  User.update_all(last_seen_at: nil)
end
