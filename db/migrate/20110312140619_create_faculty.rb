class CreateFaculty < ActiveRecord::Migration
  def self.up
    create_table :faculties do |t|
      t.string   :name, :unique => true, :null => false, :limit => 3
      t.datetime :created_at
      t.datetime :updated_at
    end

    add_column :elections, :faculty_id, :integer
    remove_column :elections, :faculty
    change_column :elections, :user_id, :integer, :null => true

    add_index :elections, [:user_id]
    add_index :elections, [:faculty_id]

    facults = %w(101 102 103 104 105)
    facults.each { |faculty| Faculty.create :name => faculty }
  end

  def self.down
    remove_column :elections, :faculty_id
    add_column :elections, :faculty, :string, :limit => 7
    change_column :elections, :user_id, :integer, :null => false

    drop_table :faculties

    remove_index :elections, :name => :index_elections_on_user_id rescue ActiveRecord::StatementInvalid
    remove_index :elections, :name => :index_elections_on_faculty_id rescue ActiveRecord::StatementInvalid
  end
end

