class RemoveElectionResults < ActiveRecord::Migration
  def self.up
    drop_table :election_results
  end

  def self.down
    create_table "election_results", :force => true do |t|
      t.datetime "created_at"
      t.datetime "updated_at"
      t.integer  "election_id"
    end

    add_index "election_results", ["election_id"], :name => "index_election_results_on_election_id"
  end
end
