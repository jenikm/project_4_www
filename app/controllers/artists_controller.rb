class ArtistsController < ApplicationController

  def index
    @artists = if params[:song_id]
      Song.find(params[:song_id]).artist
    else
      filters(Artist)
    end

    respond_to do |format|
      format.html{
        render :text => @artists.to_html
      }
      format.json{
        render :json => @artists.to_json(:include => process_includes(params[:include]))
      }
    end
  end

  def top
    age_min = params[:age_min]
    age_max = params[:age_max]
    gender = params[:gender]
    play_count_min = params[:play_count_min]
    play_count_max = params[:play_count_max]

    country_id = params[:country_id]
    where_string = []
    where_params = []
    if age_min
      where_string << "users.age >= ?" 
      where_params << age_min
    end
    if age_max
      where_string << "users.age <= ?"
      where_params << age_max
    end
    if gender
      where_string << "users.gender = ?"
      where_params << User.gender_to_index(gender)
    end

    if country_id
      where_string << "users.country_id = ?"
      where_params << country_id
    end

    if play_count_min
      where_string << "favorite_artists.play_count >= ?"
      where_params << play_count_min
    end

    if play_count_max
      where_string << "favorite_artists.play_count <= ?"
      where_params << play_count_max
    end
    
    where = [where_string.join(" AND "), *where_params]
    @artists = Artist.includes(:users).where(where).limit(params[:limit] || 100).order("favorite_artists.play_count DESC")
    respond_to do |format|
      format.html{
        render :text => @artists.to_html
      }
      format.js{
        render :json => @artists.to_json(:include => :user)
      }
    end
  end

  def show
    @artist = Artist.find(params[:id])   
    respond_to do |format|
      format.html{
        render :text => @artist.to_html
      }
      format.json{
        render :json => @artist.to_json(:include => process_includes(params[:include]))
      }
    end
  end

end
