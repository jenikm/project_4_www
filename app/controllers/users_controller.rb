class UsersController < ApplicationController

  def index
    if params[:artist_id]
      @users = filters Artist.find(params[:artist_id]).users
    elsif params[:song_id]
      @users = filters Song.find(params[:song_id]).users
    else
      @users = filters User
    end

    respond_to do |format|
      format.html{
        render :text => @users.to_html
      }
      format.json{
        render :json => @users.to_json(:include => process_includes(params[:include]))
      }
    end
  end

  def show
    @user = User.find(params[:id])   
    respond_to do |format|
      format.html{
        render :text => @user.to_html
      }
      format.json{
        render :json => @user.to_json(:include => process_includes(params[:include]))
      }
    end
  end

end
