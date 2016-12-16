class Answer < ActiveRecord::Base
	# Relationships
	belongs_to :user
	belongs_to :question

	has_many :answer_votes, dependent: :destroy
end
