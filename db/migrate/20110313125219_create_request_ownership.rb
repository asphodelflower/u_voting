class CreateRequestOwnership < ActiveRecord::Migration
  def self.up
    add_column :candidate_requests, :owner_id, :integer
    remove_column :candidate_requests, :user_id

    remove_index :candidate_requests, :name => :index_candidate_requests_on_user_id rescue ActiveRecord::StatementInvalid
    add_index :candidate_requests, [:owner_id]
  end

  def self.down
    remove_column :candidate_requests, :owner_id
    add_column :candidate_requests, :user_id, :integer

    remove_index :candidate_requests, :name => :index_candidate_requests_on_owner_id rescue ActiveRecord::StatementInvalid
    add_index :candidate_requests, [:user_id]
  end
end
