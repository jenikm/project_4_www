class TopArtistsController < ApplicationController

	def index
		if params[:ageMin] or params[:ageMax]
			table = 'top_artists2_no_country'
		else
			table = 'top_artists2_no_age'
		end
		query = <<-EOS
select id, mbid, name, plays
from artists
join (select artist_id, sum(plays) as plays
from #{table}
EOS
		where = []
		if params[:gender]
			genderClauses = []
			genderClauses << "gender = 'm'" if params[:gender].index('m')
			genderClauses << "gender = 'f'" if params[:gender].index('f')
			genderClauses << "gender is null" if params[:gender].index('u')
			where << '(' + genderClauses.join(' or ') + ')'
		end
		where << "age >= #{params[:ageMin]}" if params[:ageMin]
		where << "age <= #{params[:ageMax]}" if params[:ageMax]
		where << "country_id = #{params[:country]}" if params[:country]
		
		if where.length > 0
			query << <<-EOS
where #{where.join(' and ')}
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
