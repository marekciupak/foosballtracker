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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150624202201) do

  create_table "matches", force: :cascade do |t|
    t.integer  "winner_id"
    t.integer  "loser_id"
    t.date     "date"
    t.integer  "loser_score"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "matches", ["loser_id"], name: "index_matches_on_loser_id"
  add_index "matches", ["winner_id"], name: "index_matches_on_winner_id"

  create_table "players", force: :cascade do |t|
    t.string   "firstname"
    t.string   "lastname"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.decimal  "rank",       default: 1000.0
  end

  add_index "players", ["rank"], name: "index_players_on_rank"

end
