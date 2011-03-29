# This is an auto-generated file: don't edit!
# You can add your own routes in the config/routes.rb file
# which will override the routes in this file.

Evoting::Application.routes.draw do


  # Resource routes for controller "votes"
  get 'votes/new(.:format)', :as => 'new_vote'
  get 'votes/:id/edit(.:format)' => 'votes#edit', :as => 'edit_vote'
  get 'votes/:id(.:format)' => 'votes#show', :as => 'vote', :constraints => { :id => %r([^/.?]+) }
  post 'votes(.:format)' => 'votes#create', :as => 'create_vote'
  put 'votes/:id(.:format)' => 'votes#update', :as => 'update_vote', :constraints => { :id => %r([^/.?]+) }
  delete 'votes/:id(.:format)' => 'votes#destroy', :as => 'destroy_vote', :constraints => { :id => %r([^/.?]+) }


  # Resource routes for controller "candidates"
  get 'candidates(.:format)' => 'candidates#index', :as => 'candidates'
  get 'candidates/new(.:format)', :as => 'new_candidate'
  get 'candidates/:id/edit(.:format)' => 'candidates#edit', :as => 'edit_candidate'
  get 'candidates/:id(.:format)' => 'candidates#show', :as => 'candidate', :constraints => { :id => %r([^/.?]+) }
  post 'candidates(.:format)' => 'candidates#create', :as => 'create_candidate'
  put 'candidates/:id(.:format)' => 'candidates#update', :as => 'update_candidate', :constraints => { :id => %r([^/.?]+) }
  delete 'candidates/:id(.:format)' => 'candidates#destroy', :as => 'destroy_candidate', :constraints => { :id => %r([^/.?]+) }

  # Owner routes for controller "candidates"
  get 'elections/:election_id/candidates/new(.:format)' => 'candidates#new_for_election', :as => 'new_candidate_for_election'
  post 'elections/:election_id/candidates(.:format)' => 'candidates#create_for_election', :as => 'create_candidate_for_election'


  # Lifecycle routes for controller "users"
  put 'users/:id/reset_password(.:format)' => 'users#do_reset_password', :as => 'do_user_reset_password'
  get 'users/:id/reset_password(.:format)' => 'users#reset_password', :as => 'user_reset_password'

  # Resource routes for controller "users"
  get 'users(.:format)' => 'users#index', :as => 'users'
  get 'users/new(.:format)', :as => 'new_user'
  get 'users/:id/edit(.:format)' => 'users#edit', :as => 'edit_user'
  get 'users/:id(.:format)' => 'users#show', :as => 'user', :constraints => { :id => %r([^/.?]+) }
  post 'users(.:format)' => 'users#create', :as => 'create_user'
  put 'users/:id(.:format)' => 'users#update', :as => 'update_user', :constraints => { :id => %r([^/.?]+) }
  delete 'users/:id(.:format)' => 'users#destroy', :as => 'destroy_user', :constraints => { :id => %r([^/.?]+) }

  # Show action routes for controller "users"
  get 'users/:id/account(.:format)' => 'users#account', :as => 'user_account'

  # User routes for controller "users"
  match 'login(.:format)' => 'users#login', :as => 'user_login'
  get 'logout(.:format)' => 'users#logout', :as => 'user_logout'
  match 'forgot_password(.:format)' => 'users#forgot_password', :as => 'user_forgot_password'


  # Resource routes for controller "elections"
  get 'elections(.:format)' => 'elections#index', :as => 'elections'
  get 'elections/new(.:format)', :as => 'new_election'
  get 'elections/:id/edit(.:format)' => 'elections#edit', :as => 'edit_election'
  get 'elections/:id(.:format)' => 'elections#show', :as => 'election', :constraints => { :id => %r([^/.?]+) }
  post 'elections(.:format)' => 'elections#create', :as => 'create_election'
  put 'elections/:id(.:format)' => 'elections#update', :as => 'update_election', :constraints => { :id => %r([^/.?]+) }
  delete 'elections/:id(.:format)' => 'elections#destroy', :as => 'destroy_election', :constraints => { :id => %r([^/.?]+) }

end
