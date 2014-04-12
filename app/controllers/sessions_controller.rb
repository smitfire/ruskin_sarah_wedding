class SessionsController < ApplicationController

  def new
    @user = User.new
  end

  def create
    if User.find_by_email(params[:user][:email]) &&  params[:user][:email] == 'admin@admin.com' 
      @user =  User.find_by_email(params[:user][:email]).authenticate(params[:user][:password])
      session[:user_id] = @user.id
      redirect_to users_path
    elsif params[:user].length == 1
      @user = User.create(email: params[:user][:email])
      session.clear
      
      redirect_to root_path
    else
      @user = User.create(params[:user][:first], last: params[:user][:last], email: params[:user][:email], password: params[:user][:password], password_confirmation: params[:user][:password_confirmation], attendance: 'true')
    
      session.clear
      
      redirect_to root_path
    end
  end

  def destroy
    session.clear
    redirect_to root_path
  end
end
