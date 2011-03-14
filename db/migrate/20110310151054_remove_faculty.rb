class RemoveFaculty < ActiveRecord::Migration
  def self.up
    remove_column :elections, :faculty_id
  end

  def self.down
    add_column :elections, :faculty_id, :integer, :default => 0
  end
end
