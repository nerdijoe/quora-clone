class Question < ActiveRecord::Base
	# Relationships
	has_many :answers, dependent: :destroy
	belongs_to :user

end
