class CreateAll < ActiveRecord::Migration
  def self.up
    create_table :elections do |t|
      t.date     :start_date, :null => false
      t.date     :end_date, :null => false
      t.string   :title, :unique => true, :null => false, :limit => 128
      t.boolean  :active, :default => true
      t.integer  :faculty_id, :default => 0
      t.datetime :created_at
      t.datetime :updated_at
      t.integer  :user_id
    end
    add_index :elections, [:user_id]

    create_table :votes do |t|
      t.string   :uuid, :limit => 32, :unique=> true, :null => false
      t.datetime :created_at
      t.datetime :updated_at
      t.integer  :election_id
      t.integer  :candidate_id
    end
    add_index :votes, [:election_id]
    add_index :votes, [:candidate_id]

    create_table :candidates do |t|
      t.string   :name, :limit => 80, :null => false
      t.text     :description
      t.integer  :votes_count, :default => 0
      t.datetime :created_at
      t.datetime :updated_at
      t.integer  :election_id
    end
    add_index :candidates, [:election_id]

    create_table :ballots do |t|
      t.boolean  :cast
      t.datetime :created_at
      t.datetime :updated_at
      t.integer  :user_id
      t.integer  :election_id
    end
    add_index :ballots, [:user_id]
    add_index :ballots, [:election_id]
  end

  def self.down
    drop_table :elections
    drop_table :votes
    drop_table :candidates
    drop_table :ballots
  end
end

