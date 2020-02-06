class WikipediaAPI
  class << self
    def get_request(title:)
      uri = parse_api_url title

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
          result = JSON.parse response.body
        when Net::HTTPRedirection
          result = response
        else
          result = { message: "HTTP ERROR: code=#{response.code} message=#{response.message}" }
        end
      rescue IOError => e
        result = e.message
      rescue TimeoutError => e
        result = e.message
      rescue JSON::ParserError => e
        result = e.message
      end
      result
    end

    private

    def parse_api_url(title:)
      api_url = 'https://ja.wikipedia.org/w/api.php'
      params = URI.encode_www_form(
        action: 'query',
        format: 'json',
        prop: 'extracts',
        titles: title,
        explaintext: 1
      )
      URI.parse "#{api_url}?#{params}"
    end
  end
end
