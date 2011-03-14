class ChangedElections < ActiveRecord::Migration
  def self.up
    add_column :elections, :faculty_id, :integer
    remove_column :elections, :public
    change_column :elections, :user_id, :integer, :null => false

    add_column :users, :faculty_id, :integer

    remove_index :elections, :name => :index_elections_on_user_id rescue ActiveRecord::StatementInvalid
  end

  def self.down
    remove_column :elections, :faculty_id
    add_column :elections, :public, :boolean, :default => true
    change_column :elections, :user_id, :integer

    remove_column :users, :faculty_id

    add_index :elections, [:user_id]
  end
end
