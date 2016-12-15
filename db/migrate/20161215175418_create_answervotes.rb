class CreateAnswervotes < ActiveRecord::Migration
	def change
		create_table :answer_votes do |t|
			t.integer :vote
			t.timestamps

			t.belongs_to :user, index: true
			t.belongs_to :answer, index: true
		end

	end
end
