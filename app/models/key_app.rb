class KeyApp < ActiveRecord::Base
	belongs_to :app
    def self.save_keys(params)
		create! do |app|
			app.public_key = params["public_key"]
			app.private_key = params["private_key"]
			app.app_id = params["app_id"]
			
		end
	end
end
