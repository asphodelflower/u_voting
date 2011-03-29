class Candidate < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    name        :string, :limit => 80, :null => false
    description :text
    approved    :boolean, :default => false
    votes_count :integer, :default => 0
    timestamps
  end

  # --- Named Scopes --- #

  named_scope :approved, :conditions => {:approved => true}
  named_scope :unapproved, :conditions => {:approved => false}

  # --- Associations --- #

  has_many :votes, :dependent => :destroy
  belongs_to :owner, :class_name => "User", :creator => true
  belongs_to :election

  # --- Permissions --- #

  def create_permitted?
    owner_is?(acting_user) && !acting_user.administrator? && election.faculty.num.to_s() == acting_user.name[3]&& !election.expired?
  end

  def update_permitted?
    (acting_user.administrator? || election.owner_is?(acting_user) || owner_is?(acting_user)) && !owner_changed?
  end

  def destroy_permitted?
    acting_user.administrator? || owner_is?(acting_user) || election.owner_is?(acting_user)
  end

  def view_permitted?(field)
    if field == :approved && approved == false
      acting_user.administrator? || election.owner_is?(acting_user)
    else
      true
    end
  end

end

