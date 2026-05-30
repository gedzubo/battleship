# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2026_05_30_161902) do
  create_table "games", force: :cascade do |t|
    t.integer "challenger_id", null: false
    t.datetime "created_at", null: false
    t.integer "current_turn_user_id"
    t.datetime "deleted_at"
    t.datetime "finished_at"
    t.integer "opponent_id", null: false
    t.datetime "started_at"
    t.string "status", default: "invited", null: false
    t.integer "turn_timer_seconds"
    t.datetime "updated_at", null: false
    t.integer "winner_id"
    t.index ["challenger_id"], name: "index_games_on_challenger_id"
    t.index ["current_turn_user_id"], name: "index_games_on_current_turn_user_id"
    t.index ["deleted_at"], name: "index_games_on_deleted_at"
    t.index ["opponent_id"], name: "index_games_on_opponent_id"
    t.index ["status"], name: "index_games_on_status"
    t.index ["winner_id"], name: "index_games_on_winner_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "ip_address"
    t.datetime "updated_at", null: false
    t.string "user_agent"
    t.integer "user_id", null: false
    t.index ["user_id"], name: "index_sessions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email_address", null: false
    t.datetime "last_seen_at"
    t.string "password_digest", null: false
    t.datetime "updated_at", null: false
    t.string "username"
    t.index ["email_address"], name: "index_users_on_email_address", unique: true
  end

  add_foreign_key "games", "users", column: "challenger_id"
  add_foreign_key "games", "users", column: "current_turn_user_id"
  add_foreign_key "games", "users", column: "opponent_id"
  add_foreign_key "games", "users", column: "winner_id"
  add_foreign_key "sessions", "users"
end
