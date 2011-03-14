class RemoveRequests < ActiveRecord::Migration
  def self.up
    add_column :candidates, :owner_id, :integer

    add_index :candidates, [:owner_id]
  end

  def self.down
    remove_column :candidates, :owner_id

    remove_index :candidates, :name => :index_candidates_on_owner_id rescue ActiveRecord::StatementInvalid
  end
end
