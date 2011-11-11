class SearchesController < ApplicationController
  # GET /searches
  # GET /searches.json
  def index
    @searches = Search.all
  end

  def ndex 
  end

  def ownload 
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

  def find
    @query = params[:query]
    render :text => "Not Implemented", :layout => true
  end

end
