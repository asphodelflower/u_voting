class Mjmg < ActiveRecord::Migration
  def self.up
    change_column :elections, :faculty, :string, :limit => 7
  end

  def self.down
    change_column :elections, :faculty, :string
  end
end
