class CreateRequests < ActiveRecord::Migration
  def self.up
    create_table :candidate_requests do |t|
      t.string   :name, :limit => 80, :null => false
      t.text     :description
      t.text     :platform
      t.float    :rating
      t.datetime :created_at
      t.datetime :updated_at
      t.integer  :user_id
      t.integer  :election_id
    end
    add_index :candidate_requests, [:user_id]
    add_index :candidate_requests, [:election_id]
  end

  def self.down
    drop_table :candidate_requests
  end
end
