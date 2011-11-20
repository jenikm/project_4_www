class TopArtistsController < ApplicationController

	def index
		query = <<-EOS
select id, mbid, name, plays
from artists
join (select artist_id, sum(plays) as plays
from top_artists
EOS
		where = []
		if params[:gender]
			where << "gender = 'm'" if params[:gender].index('m')
			where << "gender = 'f'" if params[:gender].index('f')
			where << "gender is null" if params[:gender].index('u')
		end
		
		if where.length > 0
			query << <<-EOS
where #{where.join(' or ')}
EOS
		end
		query << <<-EOS
group by artist_id
order by plays desc
limit 10) ta
on ta.artist_id = artists.id;
EOS
    	result = ActiveRecord::Base.connection.execute(query)
    	render :json => result
	end

end
