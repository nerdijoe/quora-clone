require 'bcrypt'

class User < ActiveRecord::Base
	# This is Sinatra! Remember to create a migration!
	include BCrypt
	has_secure_password
	# alias_attribute :password_digest, :password
	# EMAIL_REGEX = /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i
	validates :password_digest, length: {minimum: 8}, allow_nil: true
	validates :email, :presence => true, :uniqueness => true


  # def password
  #   @password ||= Password.new(password_digest)
  # end

  # def password=(new_password)
  #   @password = Password.create(new_password)
  #   self.password_digest = @password
  # end

	def self.find_by_email(email)
		User.where(email: email).first
	end


	# def authenticate(password)
	# 	p "Authenticate"
	# 	p "@password_digest=#{@password_digest}"
	# 	p user_pass = BCrypt::Password.new(@password_digest)
		
	# 	if user_pass == password
	# 		true
	# 	else
	# 		false
	# 	end
	# end


end
