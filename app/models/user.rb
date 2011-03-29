class User < ActiveRecord::Base

  hobo_user_model # Don't put anything above this

  fields do
    name          :string, :required, :unique, :login => true
    email_address :email_address
    administrator :boolean, :default => false
    timestamps
  end

  # Voting ballots and voting elections
  has_many :ballots, :dependent => :nullify
  has_many :voting_elections, :class_name => 'Election', :through => :ballots, :source => :election
  has_many :candidates, :class_name => "Candidate", :foreign_key => "owner_id"

  # Owned elections
  has_many :owned_elections, :class_name => 'Election', :dependent => :nullify
  # This gives admin rights and an :active state to the first sign-up.
  # Just remove it if you don't want that
  before_create do |user|
    if !Rails.env.test? && user.class.count == 0
      user.administrator = true
      user.state = "active"
    end
  end

    def validate_on_create
        if !check_name?(name)
            errors.add_to_base "Username is incorrect"
        end

    end

  def check_name? (name)
    in_faculty = false
    faculties = Faculty.all
    faculties.each do |faculty|
      if faculty.num.to_s() == name[3]
        in_faculty = true
        break
      end
    end

    if (!numeric?(name) || name.size != 7)
      false
    else
      true
    end
  end

  def numeric?(object)
    true if Integer(object) rescue false
  end


  # --- Signup lifecycle --- #

  lifecycle do

    state :active, :default => true

    # create :signup, :available_to => "Guest",
    #       :params => [:name, :email_address, :password, :password_confirmation],
    #       :become => :active

    transition :request_password_reset, { :active => :active }, :new_key => true do
      UserMailer.forgot_password(self, lifecycle.key).deliver
    end

    transition :reset_password, { :active => :active }, :available_to => :key_holder,
               :params => [ :password, :password_confirmation ]

  end

  # --- Permissions --- #

  def create_permitted?
    # Only the initial admin user can be created
    # self.class.count == 0
    acting_user.administrator?
  end

  def update_permitted?
    acting_user.administrator? ||
      (acting_user == self && only_changed?(:email_address, :crypted_password,
                                            :current_password, :password, :password_confirmation))
    # Note: crypted_password has attr_protected so although it is permitted to change, it cannot be changed
    # directly from a form submission.
  end

  def destroy_permitted?
    acting_user.administrator?
  end

  def view_permitted?(field)
    true
  end

  # --- Instance methods --- #

  def cast_vote(candidate)
    # Get election
    election = Election.find(candidate.election_id)

    # Get the ballot
    ballot = Ballot.find_valid(self,election)

    # Create the vote, cast it and invalidate the ballot
    vote=nil
    transaction do
      vote = Vote.cast!(self,election,candidate,ballot)
    end
    return vote
  end

  def get_voted_elections
      voted_elections = Array.new
      ballots.each do |ballot|
        voted_elections << ballot.election if ballot.cast?
      end
      voted_elections
  end

  def get_unvoted_elections
      unvoted_elections = Array.new
      ballots.each do |ballot|
        unvoted_elections << ballot.election unless ballot.cast?
      end
      unvoted_elections
  end

  def didnt_vote?(election)
      get_unvoted_elections.each do |possible_election|
        return true if possible_election == election
      end
      return false
  end

  def is_voter?(election)
    election.voters.each do |voter|
      return true if voter.name == self.name
    end
      return false
  end

  def self.find_users_by_faculty(faculty_id)
    users = ::User.all
    voters = Array.new
    for user in users
      if user.name[3] == faculty_id.to_s()
        voters << user
      end
    end
    return voters
  end
end

