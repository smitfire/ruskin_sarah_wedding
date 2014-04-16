class User < ActiveRecord::Base

    #VALIDATIONS
    validates_uniqueness_of :email
    validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i }
    validates_presence_of :email

    #bcrypt stuff
    # has_secure_password

end