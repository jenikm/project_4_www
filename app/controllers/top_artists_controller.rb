class TopArtistsController < ApplicationController

	def index
		query = <<-EOS
select id, mbid, name, plays
from artists
join (select artist_id, sum(plays) as plays
from top_artists
group by artist_id
order by plays desc
limit 10) ta
on ta.artist_id = artists.id;
EOS
    	result = ActiveRecord::Base.connection.execute(query)
    	render :json => result
	end

end
