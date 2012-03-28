class UserKey < ActiveRecord::Base

	acts_as_api

	api_accessible :sign_in do |template|
		template.add :uid
	    template.add :credential
	end

	belongs_to :user

	validates :uid, :token, :app_id, :user_id, :presence => true

	def self.new_instance(user_auth_params)
		UserKey.create({
			:uid => user_auth_params[:uid],
			:token => user_auth_params[:token],
			:app_id => user_auth_params[:app_id],
			:user => user_auth_params[:user]
			})
	end


end
