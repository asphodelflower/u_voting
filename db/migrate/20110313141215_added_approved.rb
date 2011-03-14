class AddedApproved < ActiveRecord::Migration
  def self.up
    drop_table :candidate_requests

    add_column :candidates, :approved, :boolean, :default => false
  end

  def self.down
    remove_column :candidates, :approved

    create_table "candidate_requests", :force => true do |t|
      t.string   "name",        :limit => 80, :null => false
      t.text     "description"
      t.text     "platform"
      t.float    "rating"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.integer  "election_id"
      t.integer  "owner_id"
    end

    add_index "candidate_requests", ["election_id"], :name => "index_candidate_requests_on_election_id"
    add_index "candidate_requests", ["owner_id"], :name => "index_candidate_requests_on_owner_id"
  end
end

