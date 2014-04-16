class HomeController < ApplicationController
  
  def index
  	if session[:msg_rsvp] && session[:msg_news]
  		@rsvp_success = session[:msg_rsvp]
  		@newsletter_success = session[:msg_news]
  		render "home/index2"
  	elsif session[:msg_rsvp]
  		@rsvp_success = session[:msg_rsvp]
  		render "home/index2"
  	elsif session[:msg_news]
  		@newsletter_success = session[:msg_news]
  		render "home/index2"
  	end
  	reset_session
  end

end
