class Time_Local

	def initialize
		Time.zone = 'Eastern Time (US & Canada)' 
	end

	def now
		t = Time.zone.now
		time = t.year.to_s+'/'+t.month.to_s+'/'+t.day.to_s+' '+t.hour.to_s
	end
end