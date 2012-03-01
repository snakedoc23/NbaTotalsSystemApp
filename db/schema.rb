# encoding: UTF-8
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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120301143453) do

  create_table "games", :force => true do |t|
    t.date     "date"
    t.integer  "month"
    t.string   "season"
    t.string   "a_team"
    t.string   "h_team"
    t.integer  "a_score"
    t.integer  "h_score"
    t.float    "line"
    t.float    "line_open"
    t.integer  "total"
    t.integer  "over"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.integer  "away_team_id"
    t.integer  "home_team_id"
  end

  add_index "games", ["away_team_id"], :name => "index_games_on_away_team_id"
  add_index "games", ["home_team_id"], :name => "index_games_on_home_team_id"

  create_table "teams", :force => true do |t|
    t.string   "name"
    t.string   "city"
    t.string   "sbr_name"
    t.integer  "overs"
    t.integer  "unders"
    t.float    "line"
    t.float    "total"
    t.float    "def"
    t.float    "off"
    t.integer  "a_overs"
    t.integer  "a_unders"
    t.float    "a_line"
    t.float    "a_total"
    t.float    "a_def"
    t.float    "a_off"
    t.integer  "h_overs"
    t.integer  "h_unders"
    t.float    "h_line"
    t.float    "h_total"
    t.float    "h_def"
    t.float    "h_off"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "sym"
  end

end
