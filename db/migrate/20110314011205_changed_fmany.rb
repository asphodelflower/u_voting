class ChangedFmany < ActiveRecord::Migration
  def self.up
    change_column :ballots, :cast, :boolean, :default => false
  end

  def self.down
    change_column :ballots, :cast, :boolean
  end
end
