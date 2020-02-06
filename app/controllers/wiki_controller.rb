require 'net/http'

class WikiController < ApplicationController
  def index
    render json: { message: 'index_test' }
  end

  def show
    @result = WikipediaApi.get_request title: params[:id]
    render json: {title: @result['query']['pages'].first[1]['title'], content: @result['query']['pages'].first[1]['extract'] }
  end
end
