require 'net/http'

class WikiController < ApplicationController
  def index
    render json: { message: 'index_test' }
  end

  def show
    title = params[:id]
    api_url = 'https://ja.wikipedia.org/w/api.php'
    # params = URI.encode_www_form(
    #   action: 'query',
    #   format: 'json',
    #   prop: 'revisions',
    #   titles: title,
    #   rvprop: 'content'
    # )
    params = URI.encode_www_form(
      action: 'query',
      format: 'json',
      prop: 'extracts',
      titles: title,
      explaintext: 1
    )
    uri = URI.parse "#{api_url}?#{params}"

    https = Net::HTTP.new uri.host, uri.port
    https.use_ssl = true
    response = https.start do |connection|
      connection.open_timeout = 5
      connection.read_timeout = 10
      connection.get uri
    end

    begin
      case response
      when Net::HTTPSuccess
        @result = JSON.parse response.body
      when Net::HTTPRedirection
        @result = response
      else
        @result = { message: "HTTP ERROR: code=#{response.code} message=#{response.message}" }
      end
    rescue IOError => e
      @result = e.message
    rescue TimeoutError => e
      @result = e.message
    rescue JSON::ParserError => e
      @result = e.message
    end

    render json: @result
  end
end
