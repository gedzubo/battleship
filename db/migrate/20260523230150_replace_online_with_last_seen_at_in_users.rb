class ReplaceOnlineWithLastSeenAtInUsers < ActiveRecord::Migration[8.1]
  def change
    remove_column :users, :online, :boolean, default: false, null: false
    add_column :users, :last_seen_at, :datetime
  end
end
