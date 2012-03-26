class Users < ActiveRecord::Base
	has_many :user_keys

	acts_as_api

	api_accessible :sign_in do |template|
	    template.add :first_name
		template.add :last_name
		template.add :nick_name
		
	end
end
