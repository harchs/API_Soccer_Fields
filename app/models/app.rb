class App < ActiveRecord::Base
	has_one :key_apps
	def self.save_app(params)
		create! do |app|
			app.url = params["private_key"]
			app.name = params["app_name"]
		end
	end
end
