class UsersController < ApplicationController
  def index

  end

  def new
  	
  end
  
  def show
  	if  User.find_by_email(params[:email]).password == params[:password]
  		@user =  User.find_by_email(params[:email])
  	else
  		redirect_to root_path
  	end
  end
end
