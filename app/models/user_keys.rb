class UserKeys < ActiveRecord::Base
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
