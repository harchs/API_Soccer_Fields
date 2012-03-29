=begin apidoc
	url:: /find
	method:: GET
	access:: RESTRICTED by authentication of the app
	return:: [JSON] - list of venues objects

	param:: ll: String with latitude and longitude of geolocation of user "ll=10.43223,-74.121222"
	param:: radius: Limit results to venues within this many meters of the specified location
	param:: public_key: Public key of the app
	param:: auth_code: Code generated with private key and modifiers
	param:: valide_date: [Optional] Specifies whether or not to consider the date to generate the auth_code "aaaa/mm/dd hh"
	param:: modifiers: Modifiers used for encode the private key of the app "modifiers=m1,m2,...mn"


	output:: json
		{
		    "status": "success",
		    "code": "API_SUCCESS",
		    "message": "The operation was successful",
		    "errors": "",
		    "data": {
		        "venues": [{
		            "name": "La Bombonera",
		            "location": {
		                "address": "Kra. 46 cll 72",
		                "distance": 133
		            },
		            "contact": {
		                "phone": ""
		            }
		        }, {
		            "name": "Estadio Romelio Mart\u00ednez",
		            "location": {
		                "address": "Calle 72 # 46 Avda. Olaya Herrera con 72",
		                "distance": 936
		            },
		            "contact": {
		                "phone": ""
		            }
		        }]
		    }
		}
 	::output-end::
=end

class Api::v1::VenuesController < Api::v1::ApiController

	# before_filter :authenticate_user_token
	def find
		
		markups=[]	
		if params[:ll].blank?
			render_response("API_PARAMS_ERROR", nil, {:status => 'failure', :aditional_data => {:errors => "You must provide the geolocation data."}}) and return
		else
			venues=Foursquare_client.get_venues(right_params_for_search_venues(params[:ll],params[:radius])).groups[0].items 
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
			render_response("API_SUCCESS", markups, {:data_root => :venues})
		end
	end 

	private 
		def right_params_for_search_venues(ll,radius)
			params_for_search_venues = Hash.new
			params_for_search_venues[:ll] = ll
			unless radius.blank?
				params_for_search_venues[:radius] = radius.to_i
			end
			params_for_search_venues
		end
end
