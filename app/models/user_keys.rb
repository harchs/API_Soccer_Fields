class UserKeys < ActiveRecord::Base
	 acts_as_api

	api_accessible :name_only do |template|
	    template.add :first_name
		template.add :last_name
	end
end
