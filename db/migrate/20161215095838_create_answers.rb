class CreateAnswers < ActiveRecord::Migration
	def change
		create_table :answers do |t|
			t.string :content
			t.timestamps

			t.belongs_to :user, index: true
			t.belongs_to :question, index: true
		end

	end
end
