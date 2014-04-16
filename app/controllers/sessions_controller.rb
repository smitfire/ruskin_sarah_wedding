class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token
  def new
    @user = User.new
  end

  def update
    # session.clear   
  end
  
  def create
    if User.find_by_email(params[:user][:email]) &&  params[:user][:email] == 'admin@admin.com' 
      @user =  User.find_by_email(params[:user][:email])
      session[:user_id] = @user.id
      redirect_to users_path
    elsif params[:user][:email] && params[:user][:attendance]
      user = User.find_or_create_by(user_params)
      @user = user.update(user_params)
      session[:msg_rsvp] =  "Thanks for your RSVP!"
      redirect_to root_url
    else
      redirect_to root_url
    end
  end

  def destroy
    reset_session
    redirect_to root_url
  end


  private
    def user_params
      params.require(:user).permit(:email, :attendance, :first, :last, :newsletter, :plus_one, :meal)
    end
    def user_params_2
      params.require(:user_news).permit(:email, :newsletter)
    end
end
