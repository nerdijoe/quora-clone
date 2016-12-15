helpers do
	# This will return the current user, if they exist
	# Replace with code that works with your application
	def current_user
		if session[:user_id]
			@current_user ||= User.find_by_id(session[:user_id])
		end
	end

	# Returns true if current_user exists, false otherwise
	def logged_in?
		!current_user.nil?
	end


	def login(user)
		session[:user_id] = user.id
	end

	def logout
		session.clear
	end

	def redirect_to_index
		@error_messages = "Please login to gain access."
		erb :"/static/index"
	end

	def format_date(t)
		t.strftime('%b %d, %Y at %I:%M %p %Z')
	end

end