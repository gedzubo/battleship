class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  ONLINE_THRESHOLD = 90.seconds

  def online?
    last_seen_at&.> ONLINE_THRESHOLD.ago
  end

  def display_name
    username.present? ? "#{username} (#{email_address})" : email_address
  end
end
