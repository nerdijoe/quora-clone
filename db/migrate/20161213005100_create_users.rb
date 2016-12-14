class CreateUsers < ActiveRecord::Migration
	def change
		create_table :users do |t|
			t.string :fullname
			t.string :username
			t.string :email
			t.string :password_digest
			t.string :salt
			t.timestamps
		end

	end
end