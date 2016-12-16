class AnswerVote < ActiveRecord::Base
	# This is Sinatra! Remember to create a migration!
	#	Relationships
	belongs_to :user
	belongs_to :answer

end
