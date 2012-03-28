class Api::VenuesController < ApplicationController
	def find
		
		markups=[]	

		venues=Foursquare_client.get_venues(params_right_for_search_venues(params[:ll],params[:radius])).groups[0].items 
		# raise venues.to_s
		venues.each do |venue|

			address = ""

			if(venue.location.address!=nil)
				address += venue.location.address
			end

			if(venue.location.crossStreet!=nil)
				address += ' '+venue.location.crossStreet
			end

			phone = ""
			unless venue.contact.phone.blank? 
				phone = venue.contact.phone
			end

			markups.push ({
				:name=>venue.name,
				:location=>{
					:address=>address,
					:distance=>venue.location.distance
				},
				:contact=>{
					:phone=>phone
				}
			})
		end
		json={"venues"=> markups}
		results=JSON(json)

	 	respond_to do |format|
	       format.json { render :json => results }
	   end
		
	end 

	private 
		def params_right_for_search_venues(ll,radius)
			params_for_search_venues = Hash.new(0)
			params_for_search_venues[:ll] = ll
			p radius.blank?
			unless radius.blank?
				params_for_search_venues[:radius] = radius.to_i
			end
			params_for_search_venues
		end
end
