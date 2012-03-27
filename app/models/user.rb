class User < ActiveRecord::Base
	has_many :user_keys

	validates :first_name, :presence => true
	validates :last_name, :presence => true
	validates :email, :format => { :with => /((\S+)@(\S{3}[a-zA-z0-9)]\S*))/, :message => "not valid" } 

	acts_as_api

	api_accessible :sign_in do |template|
	    template.add :e_mail
	    template.add :user_keys
		
	end

	

end
