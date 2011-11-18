class FavoriteArtistsController < ApplicationController

  def index
    if params[:artist_id] 
      @favorite_artists = filters Artist.find(params[:artist_id]).favorite_artists
    else
      @favorite_artists = filters FavoriteArtist
    end
    respond_to do |format|
      format.html{
        render :text => @favorite_artists.to_html
      }
      format.json{
        render :json => @favorite_artists.to_json(:include => process_includes(params[:include]))
      }
    end
  end

end
