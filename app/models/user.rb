require 'bcrypt'

class User < ActiveRecord::Base
	# This is Sinatra! Remember to create a migration!
	include BCrypt
	has_secure_password
	# alias_attribute :password_digest, :password
	# EMAIL_REGEX = /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i
	EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/

	validates :username, :presence => true, :uniqueness => true, :length => { :in => 3..20 }
	validates :password_digest, length: {minimum: 8}, allow_nil: true
	validates :email, :presence => true, :uniqueness => true, format: {with: EMAIL_REGEX, message: "email is invalid"}


	# These methods are defined in the has_secure_password
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

	# custom authenticate method
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
