class Game < ApplicationRecord
  belongs_to :challenger, class_name: "User"
  belongs_to :opponent, class_name: "User"
  belongs_to :winner, class_name: "User", optional: true
  belongs_to :current_turn_user, class_name: "User", optional: true

  enum :status, {
    invited: "invited",
    declined: "declined",
    placing_ships: "placing_ships",
    in_progress: "in_progress",
    finished: "finished"
  }

  default_scope { where(deleted_at: nil) }

  scope :history, -> { where(status: [ :in_progress, :finished ]) }

  def soft_delete
    update!(deleted_at: Time.current)
  end

  def deleted?
    deleted_at.present?
  end
end
