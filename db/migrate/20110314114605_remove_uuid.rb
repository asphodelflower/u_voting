class RemoveUuid < ActiveRecord::Migration
  def self.up
    remove_column :votes, :uuid
  end

  def self.down
    add_column :votes, :uuid, :string, :limit => 32, :null => false
  end
end
