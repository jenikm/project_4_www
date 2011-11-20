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
    @@x||=0
    @@x+=1
    render :text => @@x.to_s
  end

  def find
    @query = params[:query]
    render :text => "Not Implemented", :layout => true
  end

end
