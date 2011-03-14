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

ActiveRecord::Schema.define(:version => 20110314184414) do

  create_table "ballots", :force => true do |t|
    t.boolean  "cast",        :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "election_id"
  end

  add_index "ballots", ["election_id"], :name => "index_ballots_on_election_id"
  add_index "ballots", ["user_id"], :name => "index_ballots_on_user_id"

  create_table "candidates", :force => true do |t|
    t.string   "name",        :limit => 80,                    :null => false
    t.text     "description"
    t.integer  "votes_count",               :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "election_id"
    t.integer  "owner_id"
    t.boolean  "approved",                  :default => false
  end

  add_index "candidates", ["election_id"], :name => "index_candidates_on_election_id"
  add_index "candidates", ["owner_id"], :name => "index_candidates_on_owner_id"

  create_table "elections", :force => true do |t|
    t.date     "start_date",                                      :null => false
    t.date     "end_date",                                        :null => false
    t.string   "title",         :limit => 128,                    :null => false
    t.boolean  "active",                       :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.boolean  "expired",                      :default => false
    t.integer  "votes_count",                  :default => 0
    t.integer  "ballots_count",                :default => 0
    t.integer  "faculty_id"
  end

  add_index "elections", ["faculty_id"], :name => "index_elections_on_faculty_id"
  add_index "elections", ["user_id"], :name => "index_elections_on_user_id"

  create_table "faculties", :force => true do |t|
    t.string   "name",       :limit => 3, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.string   "remember_token"
    t.datetime "remember_token_expires_at"
    t.string   "name"
    t.string   "email_address"
    t.boolean  "administrator",                           :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "state",                                   :default => "active"
    t.datetime "key_timestamp"
  end

  add_index "users", ["state"], :name => "index_users_on_state"

  create_table "votes", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "election_id"
    t.integer  "candidate_id"
  end

  add_index "votes", ["candidate_id"], :name => "index_votes_on_candidate_id"
  add_index "votes", ["election_id"], :name => "index_votes_on_election_id"

end
