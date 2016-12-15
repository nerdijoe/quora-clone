class CreateQuestionvotes < ActiveRecord::Migration
	def change
		create_table :question_votes do |t|
			t.integer :vote
			t.timestamps

			t.belongs_to :user, index: true
			t.belongs_to :question, index: true
		end
	end
end
