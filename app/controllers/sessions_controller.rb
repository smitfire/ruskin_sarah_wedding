class SessionsController < ApplicationController

  def new
    @user = User.new
  end

  def create
    if User.find_by_email(params[:user][:email]) &&  params[:user][:email] == 'admin@admin.com' 
      @user =  User.find_by_email(params[:user][:email])
      session[:user_id] = @user.id
      redirect_to users_path
    elsif params[:user][:email] && params[:user][:attendance]
      @user = User.find_or_create_by(user_params)
      
      session[:msg_rsvp] =  "Thanks for your RSVP!"
      redirect_to root_path

    elsif params[:user][:email] && params[:user][:newsletter]
      @user = User.find_or_create_by(user_params)
      
      session[:msg_news] =  "Thanks for signing up!"
      redirect_to root_path
      
    end
  end

  def destroy
    session.clear
    redirect_to root_path
  end


  private
    def user_params
      params.require(:user).permit(:email, :attendance, :first, :last, :newsletter, :plus_one, :meal)
      
    end
end
