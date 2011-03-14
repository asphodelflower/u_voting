class ChangedElection < ActiveRecord::Migration
  def self.up
    add_column :elections, :public, :boolean, :default => true
    add_column :elections, :expired, :boolean, :default => false
    add_column :elections, :votes_count, :integer, :default => 0
    add_column :elections, :ballots_count, :integer, :default => 0
  end

  def self.down
    remove_column :elections, :public
    remove_column :elections, :expired
    remove_column :elections, :votes_count
    remove_column :elections, :ballots_count
  end
end
