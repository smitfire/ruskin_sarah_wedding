class UsersController < ApplicationController

	# GET users/new
	def new
		@user = User.new
	end
	
	def index
		if current_user.first == 'Admin'
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

	def create
		# @user = User.new params[:user]
		# if @user.save
		# 	session[:user_id] = @user.id
		# 	redirect_to root_url, :notice => 'Welcome!'
		# else
		# 	render 'new'
		# end
	end

	def show
    	@user = User.find(params[:id])
  	end

end