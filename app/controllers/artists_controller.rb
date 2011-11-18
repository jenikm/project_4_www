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
