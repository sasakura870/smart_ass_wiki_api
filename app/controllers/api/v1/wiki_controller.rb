class WikiController < ApplicationController
  def index
    render json: { message: 'index_test' }
  end

  def show
    render json: { message: 'test' }
  end
end
