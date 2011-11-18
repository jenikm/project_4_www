class TrackPlaysController < ApplicationController

  def index
    if params[:song_id] 
      @track_plays = filters Song.find(params[:song_id]).track_plays
    else
      @track_plays = filters TrackPlay
    end
    respond_to do |format|
      format.html{
        render :text => @track_plays.to_html
      }
      format.json{
        render :json => @track_plays.to_json(:include => process_includes(params[:include]))
      }
    end
  end

end
