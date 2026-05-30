class CreateGames < ActiveRecord::Migration[8.1]
  def change
    create_table :games do |t|
      t.references :challenger, null: false, foreign_key: { to_table: :users }
      t.references :opponent, null: false, foreign_key: { to_table: :users }
      t.references :winner, null: true, foreign_key: { to_table: :users }
      t.references :current_turn_user, null: true, foreign_key: { to_table: :users }
      t.string :status, null: false, default: "invited"
      t.integer :turn_timer_seconds
      t.datetime :started_at
      t.datetime :finished_at
      t.datetime :deleted_at

      t.timestamps
    end

    add_index :games, :status
    add_index :games, :deleted_at
  end
end
