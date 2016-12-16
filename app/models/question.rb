class Question < ActiveRecord::Base
	# Relationships
	has_many :answers, dependent: :destroy
	belongs_to :user

	has_many :question_votes, dependent: :destroy

end
