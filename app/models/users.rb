
class Users < ActiveRecord::Base
	has_many :user_keys

	def self.save_user(params)
		create! do |user|
			user.first_name = params["first_name"]
			user.last_name = params["last_name"]
			user.nick_name = params["nick_name"]
			user.email = params["email"]
		end
	end

	
end
