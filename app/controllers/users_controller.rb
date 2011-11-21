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

  def gender_stats
    @artist = Artist.find(params[:artist_id])
    genders = @artist.users.select("gender, count(1)").group("gender")
    respond_to do |format|
      format.html{
        render :text => genders.to_html
      }
      format.json{
        render :json => genders
      }
    end
  end

  def age_stats
    @artist = Artist.find(params[:artist_id]) 
    ages = @artist.users.select("age, count(1)").group("age").order("age asc")
    age_ranges = []
    (1..10).each do |i|
      age_ranges << { "#{ i * 10 - 10}-#{i * 10 - 1}" => ages.select{|a| ((i*10 - 10)...(i*10)) === a.age }.map{|c| c.count.to_i}.sum}
    end
    bad_ranges = []
    age_ranges.each do |age_range|
      if age_range.values.first.zero?
        bad_ranges << age_range 
      else
        break
      end
    end
    age_ranges.reverse.each do |age_range|
      if age_range.values.first.zero?
        bad_ranges << age_range 
      else
        break
      end
    end
    age_ranges -= bad_ranges
     respond_to do |format|
      format.html{
        render :text => age_ranges.to_html
      }
      format.json{
        render :json => age_ranges
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
