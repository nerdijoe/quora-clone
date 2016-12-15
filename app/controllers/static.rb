# use Rack::Session::Cookie, :key => 'rack.session',
#                            :expire_after => 2592000, # In seconds
#                            :secret => 'super pass'

enable :sessions
set :session_secret, '*&(^B234'

require 'pp'

get '/' do
	pp "index"
	if !logged_in?
	  erb :"static/index"
	else
		redirect to '/home'
	end
end

get '/home' do
	if !logged_in?
		redirect_to_index
	else
		@questions = Question.order(:created_at)
		byebug
		erb :'static/home'
	end
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
	@user.destroy

	redirect to :'/'
end

# **************************************************************************
# Questions
# **************************************************************************

get '/questions' do
	# redirect to '/' if !logged_in?
	if !logged_in?
		redirect_to_index
	else
		pp "/questions"
		@questions = Question.where(user_id: current_user.id)

		erb :'/static/questions'
	end	
end


post '/questions' do
	redirect to '/' if !logged_in?

	pp params
	@new_question = Question.new(params[:question])
	@new_question.user_id = current_user.id
	
	if @new_question.save
		# what should happen if the user is save?
		pp "Question is saved"
		# AJAX
		# {user_object: @new_user}.to_json
	else
	# what should happen if the user keyed in invalid date?
		pp "Question is not saved"
		pp @new_question.errors
	end

	pp "*** end of /questions new ***"
	


	redirect to :'/questions'
end



get '/questions/:id' do
	# redirect to '/' if !logged_in?
	if !logged_in?
		redirect_to_index
	else
		pp @question = Question.find(params[:id])

		erb :'/static/questions_details'
	end
end


post '/questions/:id/answers' do
	pp params
	

	@new_answer = Answer.new(params[:answer])
	@new_answer.user_id = current_user.id
	@new_answer.question_id = params[:id]

	
	if @new_answer.save
		# what should happen if the user is save?
		pp "Answer is saved"
		# AJAX
		# {user_object: @new_user}.to_json
	else
	# what should happen if the user keyed in invalid date?
		pp "Answer is not saved"
		pp @new_answer.errors
	end

	# @question = Question.find(params[:id])

	redirect to '/questions/' + params[:id]
	# erb :'/static/questions_details'
end


get '/questions/:id/edit' do
	# redirect to '/' if !logged_in?
	if !logged_in?
		redirect_to_index
	else
		pp @question = Question.find(params[:id])
		erb :"static/questions_edit"
	end
end

patch '/questions/:id' do
	pp "*** edit question"
	pp @question = Question.find(params[:id])
	
	@question.content = params[:question][:content]
	@question.save

	# redirect to :"/questions/#{@user.id}"
	redirect to '/questions/' + params[:id]
end


delete '/questions/:id/delete' do
	redirect to '/' if !logged_in?

	pp @question = Question.find(params[:id])

	@question.destroy

	redirect to '/questions'

end


# **************************************************************************
# Answers
# **************************************************************************

get '/answers' do
	# redirect to '/' if !logged_in?
	# redirect_unknown_user
	pp "answers"
	if !logged_in?
		redirect_to_index
	else
		pp "why?"
		@answers = Answer.where(user_id: current_user.id)
		
		erb :'/static/answers'
	end

end

get '/answers/:id/edit' do
	if !logged_in?
		redirect_to_index
	else
		pp @answer = Answer.find(params[:id])
		erb :"static/answers_edit"
	end
end


patch '/answers/:id' do
	pp "*** edit answer"
	pp @answer = Answer.find(params[:id])
	
	byebug
	@answer.content = params[:answer][:content]
	@answer.save

	redirect to '/answers'
end

delete '/answers/:id/delete' do
	redirect to '/' if !logged_in?

	pp @answer = Answer.find(params[:id])

	@answer.destroy

	redirect to '/answers'

end


