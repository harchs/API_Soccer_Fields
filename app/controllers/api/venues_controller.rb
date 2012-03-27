class Api::VenuesController < ApplicationController
	def find
		if params[:lat]== nil || params[:lng]==nil
			params[:lat]="10.98940092958238"
			params[:lng]="-74.7999849319458"
		end
		p params.to_s
		lat= params[:lat]
		lng= params[:lng]

		params[:ll]=lat+", "+lng
		markups=[]

		markups.push ({
				"lat"=> lat, 
				"lng"=> lng,
				"image"=>"http://lh3.ggpht.com/avlZSzbiNYEFPmfN87cVzkmh9Z-2D53tHR8tBT7JhMPytvapW6wzOgrzuJpEtxqHXBoohR59SF9KaBNz=s48",
				"tittle"=>"you are here",
				"address"=>""	
			})
		
		@venues=Foursquare_client.get_venues_by_category(params).groups[0].items 
		# raise venues.to_s
		
end
