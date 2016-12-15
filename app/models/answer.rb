class Answer < ActiveRecord::Base
	# Relationships
	belongs_to :user
	belongs_to :question

end
