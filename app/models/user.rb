class User < ActiveRecord::Base
	attr_accessible :password, :password, :password_confirmation
	
	EMAIL_REGEX = /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i
	
	validates :username, :presence => true, :uniqueness => true, :length => { :in => 3..20 }
  	validates :email, :presence => true, :uniqueness => true, :format => EMAIL_REGEX
  	
  	has_secure_password
  	validates_presence_of :password, :on => :create

	def self.authenticate(name, pass)
		# if 
		
	end

end
