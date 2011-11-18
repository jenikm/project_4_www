class SongsController < ApplicationController

  def index
    songs = Song
    if params[:artist_id]
      @artist = Artist.find params[:artist_id] 
      songs = @artist.songs
    end
    @songs = filters songs
    respond_to do |format|
      format.html{
        render :text => @songs.all.to_html
      }
      format.json{
        render :json => @songs.all.to_json(:include => process_includes(params[:include]))
      }
    end
  end

  def show
    @song = Song.find(params[:id])
    respond_to do |format|
      format.html{
        render :text => @song.to_html
      }
      format.json{
        render :json => @song.to_json(:include => process_includes(params[:include]))
      }
    end
  end

end
