class CreateQuestions < ActiveRecord::Migration
	def change
		create_table :questions do |t|
			t.string :content
			t.timestamps

			t.belongs_to :user, index: true
		end


	end
end
