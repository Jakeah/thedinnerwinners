# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20190928143657) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "nfl_matchups", force: :cascade do |t|
    t.integer  "season_year",       null: false
    t.integer  "home_team_id",      null: false
    t.integer  "away_team_id",      null: false
    t.integer  "week",              null: false
    t.datetime "game_start_time"
    t.integer  "matchup_winner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "teams", force: :cascade do |t|
    t.string   "name",       default: "", null: false
    t.string   "shortname",  default: "", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_matchup_selections", force: :cascade do |t|
    t.integer  "user_id",            null: false
    t.integer  "nfl_matchup_id",     null: false
    t.integer  "selected_winner_id"
    t.integer  "confidence_points"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "week"
    t.integer  "season_year"
  end

  create_table "user_matchups", force: :cascade do |t|
    t.integer "player_one_id",     null: false
    t.integer "player_two_id",     null: false
    t.integer "week",              null: false
    t.integer "season_year",       null: false
    t.integer "matchup_winner_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.boolean  "is_admin",               default: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

end
