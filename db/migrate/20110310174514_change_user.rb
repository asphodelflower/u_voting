class ChangeUser < ActiveRecord::Migration
  def self.up
    change_column :users, :faculty_id, :string, :limit => 7
  end

  def self.down
    change_column :users, :faculty_id, :integer
  end
end
