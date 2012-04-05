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

ActiveRecord::Schema.define(:version => 20120405184638) do

  create_table "games", :force => true do |t|
    t.integer  "match_id"
    t.integer  "winner_id"
    t.integer  "winner_score"
    t.integer  "loser_id"
    t.integer  "loser_score"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "games", ["loser_id"], :name => "index_games_on_loser_id"
  add_index "games", ["winner_id"], :name => "index_games_on_winner_id"

  create_table "matches", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "occured_at"
    t.integer  "winner_id"
    t.integer  "loser_id"
    t.integer  "winner_score"
    t.integer  "loser_score"
  end

  create_table "players", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "rank"
    t.boolean  "active",         :default => true
    t.integer  "initial_rating"
  end

end
