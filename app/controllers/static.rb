# use Rack::Session::Cookie, :key => 'rack.session',
#                            :expire_after => 2592000, # In seconds
#                            :secret => 'super pass'

enable :sessions
set :session_secret, '*&(^B234'

require 'pp'

get '/' do
	pp "home"
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
		pp "user is not saved"
		pp @new_user.errors
	end
	pp "*** end of post /signup ***"
end



get '/users/new' do
	erb :"static/signup"
end

post '/users' do
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
		pp @new_user.errors
	end

	pp "*** end of post /signup ***"
	@new_user
	erb :"static/signup"
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
		if @user.authenticate(params[:user][:password])
			puts "Password is correct"
			# session[:user_id] = @user.id
			login(@user)
		else
			puts "password is wrong"
			@error_messages = "You may input a wrong email or password. Please try again."
		end
	end

	erb :"static/index"
end

get '/logout' do
	logout
	erb :"static/index"
end

get '/users/:id' do
	p "User profile"
	pp params

	redirect to '/' if !logged_in?

	p @user = User.find(params[:id])
	erb :"static/profile"

end


get '/users/:id/edit' do
	redirect to '/' if !logged_in?

	pp @user = User.find(params[:id])
	erb :"static/profile_edit"
end

patch '/users/:id' do
	pp "*** edit user"
	pp @user = User.find(params[:id])
	byebug
	@user.fullname = params[:user][:fullname]
	@user.username = params[:user][:username]
	@user.email = params[:user][:email]
	@user.save

	redirect to :"/users/#{@user.id}"
end


delete '/users/:id/delete' do
	redirect to '/' if !logged_in?

	pp @user = User.find(params[:id])

	byebug
	@user.delete

	redirect to :'/'
end


