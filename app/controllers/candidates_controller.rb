class CandidatesController < ApplicationController

  hobo_model_controller

  auto_actions :all #-- not 1st iteration
  #auto_actions :all, :except => :index # 1st iteration
  auto_actions_for :election, [:new, :create]

  #def index
      # not 1st iteration
      # hobo_index Candidate.approved.apply_scopes(:search    => [params[:search], :name],
      #                      :faculty_is => params[:faculty],
      #                              :order_by  => parse_sort_param(:name, :faculty))


  #end



end

