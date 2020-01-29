module API
  module V1
    class WikiController < ApplicationController
      def index
        render json: { message: 'index_test' }
      end

      def show
        render json: { message: 'test' }
      end
    end
  end
end
