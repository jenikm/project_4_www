class SearchesController < ApplicationController
  # GET /searches
  # GET /searches.json
  def index
  end

  def review 
  end

  def applet 
  end

  def data_extraction 
  end

  def observations 
  end

  def instructions
  end

  def test
    if params[:key]
      x = Rails.cache.read(params[:key])
      x ||=0
      x+=1
      Rails.cache.write(params[:key], x)
      render :text => x
    else
      render :text => "NOTHING"
    end
  end

  def find
    @query = params[:query]
    render :text => "Not Implemented", :layout => true
  end

end
