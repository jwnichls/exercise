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

ActiveRecord::Schema.define(version: 20130823051125) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authorizations", force: true do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "user"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "campaigns", force: true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.text     "instructions"
    t.string   "survey_question_one"
    t.string   "survey_question_two"
    t.string   "survey_question_three"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "turk_question"
    t.text     "turk_properties"
  end

  create_table "posts", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "body"
    t.integer  "user_id"
    t.boolean  "deleted",     default: false, null: false
    t.integer  "vote_count",  default: 0,     null: false
    t.boolean  "disabled",    default: false, null: false
    t.text     "tweet_body"
    t.integer  "campaign_id"
  end

  create_table "sessions", force: true do |t|
    t.string   "session_id", null: false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id", unique: true, using: :btree
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at", using: :btree

  create_table "surveys", force: true do |t|
    t.integer  "user_id"
    t.integer  "ls1"
    t.integer  "ls2"
    t.integer  "ls3"
    t.integer  "ils1"
    t.boolean  "sanitycheck1"
    t.text     "url1"
    t.text     "url2"
    t.text     "tweet1"
    t.text     "tweet2"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "campaign_id"
  end

  create_table "turk_hits", force: true do |t|
    t.string   "hit_id"
    t.string   "hit_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tweets", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "tweet_id",   limit: 8
    t.string   "tweet_type"
    t.integer  "user_id"
    t.integer  "post_id"
    t.text     "tweet_json"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "t_nickname"
    t.string   "t_location"
    t.string   "t_image"
    t.string   "t_description"
    t.string   "t_access_token"
    t.string   "t_access_secret"
    t.string   "t_screen_name"
    t.integer  "t_followers_count"
    t.integer  "t_listed_count"
    t.integer  "t_statuses_count"
    t.string   "t_created_at"
    t.string   "version_string"
    t.string   "user_level",        default: "contributor"
    t.string   "condition"
    t.string   "turkerId"
    t.text     "twitter_json"
  end

  create_table "votes", force: true do |t|
    t.integer  "post_id"
    t.integer  "user_id"
    t.string   "vote_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
