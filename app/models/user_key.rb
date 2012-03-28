class UserKey < ActiveRecord::Base

	acts_as_api

	api_accessible :sign_in do |template|
		template.add :uid
	    template.add :credential
	end

	belongs_to :user

	validates :uid, :token, :app_id, :user_id, :presence => true



	def disable_credential!
    	self.update_attribute(:credential, "")
  	end


end
