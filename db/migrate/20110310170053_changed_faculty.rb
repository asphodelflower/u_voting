class ChangedFaculty < ActiveRecord::Migration
  def self.up
    change_column :elections, :faculty_id, :string, :limit => 7
  end

  def self.down
    change_column :elections, :faculty_id, :integer
  end
end
