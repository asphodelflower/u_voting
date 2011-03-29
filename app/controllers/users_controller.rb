class UsersController < ApplicationController

  hobo_user_controller

  #auto_actions :all, :except => [ :index, :new, :create ]

  auto_actions :all

  def create
    hobo_create do
      if valid?
        self.current_user = this
        flash[:notice] = t("hobo.messages.you_are_site_admin", :default=>"You are now the site administrator")
        redirect_to home_page

        flash[:notice] = "User created successfully"
        redirect_to(object_url(this))
      end
    end
  end

end

