class ChnagedUsers < ActiveRecord::Migration
  def self.up
    remove_column :users, :faculty_id
  end

  def self.down
    add_column :users, :faculty_id, :string, :limit => 7
  end
end
