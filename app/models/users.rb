
class Users < ActiveRecord::Base
	has_many :user_keys

	acts_as_api

	api_accessible :sign_in do |template|
	    template.add :first_name
		template.add :last_name
		template.add :nick_name
		
	end
	def self.save_user(params)
		create! do |user|
			user.first_name = params["first_name"]
			user.last_name = params["last_name"]
			user.nick_name = params["nick_name"]
			user.email = params["email"]
		end
	end

end
