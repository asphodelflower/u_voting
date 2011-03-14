class ElectionsController < ApplicationController
  hobo_model_controller

  auto_actions :all

    # Creates a new election, receiving voter and candidate lists
  def create

    # Create election from parameters
    @election = Election.new(params[:election])
    @election.owner = current_user

    faculty_id = params[:election][:faculty_id]
    faculty_name = Faculty.find(@election.faculty_id).name

    # Get votes by faculty
    voters = Array.new
    voters = ::User.find_users_by_faculty(faculty_name)

    # Validates existence of voters
    if voters.empty?
      flash[:error] = "The are no registered students on a faculty"
      redirect_back_or_default(:action => 'new')
      return
    end

    # Create voting ballots
    ballots = Array.new
    voters.each do |voter|
      ballot = Ballot.new_from_params(voter, @election)
      ballots << ballot
    end

    # Save the records to the database
    begin
      Election.transaction do
        @election.save!
        ballots.each {|b| b.save!}
      end
    rescue Exception
      render :action => :new and return
    end

    # If everything went ok, notify the voters
    #for voter in voters
    #  Notifier.deliver_election_warning(voter,@election)
    #end
    flash[:notice] = "Election created successfully"
    redirect_to(object_url(@election))
  end

  def index
    hobo_index Election.apply_scopes(:search    => [params[:search], :active],
                            :faculty_is => params[:faculty],
                                    :order_by  => parse_sort_param(:active, :faculty))
    update_activity
  end

  def show
    @election = find_instance
    @candidates =
      @election.candidates.apply_scopes(:search    => [params[:search], :name],
                                    :order_by  => parse_sort_param(:name))
  end

  def cast
      @election = find_instance
      if current_user.didnt_vote?(@election)
        candidate = Candidate.find(params[:candidate_id])
        current_user.cast_vote(candidate)
        flash[:notice] = "You vote has been cast"
        redirect_to(object_url(@election))
      else
        flash[:error] = "You have already voted"
        redirect_to(object_url(@election))
      end
  end

  def results
    @election = find_instance
    @candidates = @election.candidates.order("votes_count desc")
    @winner = candidates.first
    render(:action => 'results', :layout => false) and return
  end

  def statistics
  end

  def update_activity
    # Close elections
    elections = Election.all
    elections.each do |election|
      election.start_if_time
      election.close_if_time
    end
  end

end

