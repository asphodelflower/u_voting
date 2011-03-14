class Vote < ActiveRecord::Base
  hobo_model # Don't put anything above this



  fields do
    timestamps
  end

  belongs_to :election, :counter_cache => :votes_count
  belongs_to :candidate, :counter_cache => :votes_count

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

  def self.cast!(user, election, candidate, ballot)
    vote = new
    vote.election = election
    vote.candidate = candidate
    #vote.uuid = UUID.random_create.to_s
    # TODO: detect UUID collision and generate new
    vote.save!
    ballot.cast!
    vote
  end

end

