class CreateResults < ActiveRecord::Migration
  def self.up
    create_table :election_results do |t|
      t.datetime :created_at
      t.datetime :updated_at
      t.integer  :election_id
    end
    add_index :election_results, [:election_id]
  end

  def self.down
    drop_table :election_results
  end
end
