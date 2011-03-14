class Election < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    start_date :date, :null => false
    end_date   :date, :null => false
    title      :string, :unique => true, :null => false, :limit => 128
    active     :boolean, :default => true
    expired :boolean, :default => false
    votes_count :integer, :default => 0
    ballots_count :integer, :default => 0
    user_id :integer, :null => false
    timestamps
  end

  children :candidates

  has_many :candidates, :dependent => :destroy
  has_many :ballots, :dependent => :destroy
  has_many :voters, :class_name => 'User', :through => :ballots, :source => :user
  has_many :votes, :dependent => :destroy
  has_many :null_votes, :class_name => 'Vote', :conditions => 'candidate_id IS NULL'
  belongs_to :owner, :class_name => 'User', :foreign_key => 'user_id'
  belongs_to :faculty, :class_name => 'Faculty', :foreign_key => 'faculty_id'

  def validate_on_create
    if start_date <= Date.today
      errors.add :start_date, "The election must begin in the future"
    end
    if end_date < start_date
      errors.add_to_base "End date must be later than start date"
    end
  end

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

  def start
    self.active = true
    save!
    #TODO: send mail
  end

  #Ends the current election, and disables all the unused ballots.
  def close
    self.active = false
    self.expired = true
    save!
    ballots.each do |b|
      b.cast = true
      b.save!
      #Notifier.deliver_election_end(b.user,title)
    end
  end

  def start_if_time
    if !active && !expired && start_date <= Date.today
      start
    end
  end

  def close_if_time
    if active && end_date == Date.today
      close
    end
  end

  def get_results

  end

  def expired?
    expired
  end

  def active?
    active
  end

end

