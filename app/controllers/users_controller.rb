class UsersController < ApplicationController
	skip_before_action :verify_authenticity_token
	# GET users/new
	def new
		@user = User.new
	end
	
	def index
		if User.find(session[:user_id]).first == 'Admin'
			@users = User.all
			@count = 0
			@users.each do |user|
				if user.plus_one 
					@count += user.plus_one
				end
				@count	
			end
		else
			redirect_to root_url
		end	
	end

	def update
		session.clear
	end

	def create
		if params[:user_news][:email] && params[:user_news][:newsletter]
			user = User.find_or_create_by(user_params)
			@user = user.update(user_params)
			session[:msg_news] =  "Thanks for signing up!"
			redirect_to root_url
		else
			reset_session
			redirect_to root_url
		end
	end


	def show
    	@user = User.find(params[:id])
  	end

  	private
	    def user_params
	     	params.require(:user_news).permit(:email, :newsletter)     
	    end
end