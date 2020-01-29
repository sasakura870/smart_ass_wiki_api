class WikiController < ApplicationController
  def index
    render json: { message: 'index_test' }
  end

  def show
    title = params[:id]
    url = 'http://ja.wikipedia.org/w/api.php'
    params = URI.encode_www_form(
      action: 'query',
      format: 'json',
      prop: 'revisions',
      titles: title,
      rvprop: 'content'
    )
    uri = URI.parse "#{url}?#{params}"
    render json: { uri: uri, path: uri.path, query: uri.query }
  end
end
