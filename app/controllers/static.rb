use Rack::Session::Cookie, :key => 'rack.session',
                           :path => '/',
                           :expire_after => 2592000, # In seconds
                           :secret => 'super pass'

require 'pp'

get '/' do
  erb :"static/index"
end

get '/signup' do
	erb :"static/signup"
end

post '/signup' do
	
	pp params

	pp @new_user = User.new(params[:user])

	if @new_user.save
	# what should happen if the user is save?
		pp "User is saved"
		# AJAX
		# {user_object: @new_user}.to_json


	else
	# what should happen if the user keyed in invalid date?
		pp "user is not saved"
	end

	pp "*** end of post /signup ***"

end



post '/login' do
	pp "LOGIN"
	pp params
	pp params[:user][:email]
	pp params[:user][:password]

	pp session
	# pp session[:message]
	# pp session[:id] = ""

	pp @user = User.find_by_email(params[:user][:email])

	#if user notfound
	if @user.nil?
		puts "user does not exist"
		erb :"static/signup"
	else
		#if found do stuff		
		if @user.authenticate(params[:user][:password])
			puts "Password is correct"
			session[:id] = @user.id
		else
			puts "password is wrong"

		end

		#authenticate user
		# if @user.authenticate(params[:user][:password])
		# 	session[:id] = @user.id
		# 	puts "Password is correct"
		# else
		# 	puts "password is wrong"
		# end

	end


	erb :"static/index"
end
