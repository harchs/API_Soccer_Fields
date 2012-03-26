class UserKeys < ActiveRecord::Base

	acts_as_api

	api_accessible :name_only do |template|
	    template.add :first_name
		template.add :last_name
	end
	belongs_to :users

	def self.save_keys(params)
		create! do |user|
			user.uid = params["uid"]
			user.token = params["token"]
			user.app_id = params["app_id"]
			user.user_id = params["user_id"]
		end
	end

	def self.disable_credential!
    	self.update_attribute(:credential, "")
  	end

  	def save_credential(credential)
    	self.update_attribute(:credential, credential)
  	end

end
