class BallotNotFound < Exception
end

class BallotAlreadyUsed < Exception
end

class Ballot < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    cast :boolean, :default => false
    timestamps
  end

  belongs_to :user
  belongs_to :election, :counter_cache => true
  # --- Permissions --- #

  def create_permitted?
    acting_user.administrator?
  end

  def update_permitted?
    acting_user.administrator?
  end

  def destroy_permitted?
    acting_user.administrator?
  end

  def view_permitted?(field)
    true
  end

  # --- Methods --- #

  def self.new_from_params(user,election)
    ballot = Ballot.new
    ballot.user = user
    ballot.election = election
    ballot.cast = false
    ballot
  end

  def self.find_valid(user,election)
    #ballot = Ballot.find(:first, :conditions => ["cast = ? AND election_id = ? AND user_id = ?", 'false', election.id, user.id])
    ballot = Ballot.where(:cast => false, :election_id => election.id, :user_id => user.id).first
    raise BallotNotFound if ballot.nil?
    raise BallotAlreadyUsed if ballot.cast?
    ballot
  end

  def cast!
    raise BallotAlreadyUsed if cast
    # Wouldn't work with standard assignment
    write_attribute :cast, true
    save!
    true
  end

end

