class ChangedFac < ActiveRecord::Migration
  def self.up
    add_column :elections, :faculty, :string
    remove_column :elections, :faculty_id
  end

  def self.down
    remove_column :elections, :faculty
    add_column :elections, :faculty_id, :string, :limit => 7
  end
end
