class SearchesController < ApplicationController
  
  def search
  end

  def foursquare
    #the begin-rescue-end are a block and wrapper for the commented-out req.options.timeout. If the timeout is not used, the begin-rescue-end statements can be removed. 
    # begin
      @resp = Faraday.get "https://api.foursquare.com/v2/venues/search" do |req|
        req.params['client_id'] = ''
        req.params['client_secret'] = ''
        req.params['v'] = '20160201'
        req.params['m'] = 'foursquare'
        req.params['near'] = params[:zipcode]
        req.params['radius'] = 2000
        req.params['query'] = 'coffee shop'
        # req.options.timeout = 0
      end

      resp_body = JSON.parse(@resp.body)
      if @resp.success?
        @venues = resp_body["response"]["venues"]
      else
        @error = resp_body["meta"]["errorDetail"]
      end

  # rescue Faraday::ConnectionFailed
    # # @error = "There was a timeout, Please try again."
  # end

    render 'search'
  end

end
