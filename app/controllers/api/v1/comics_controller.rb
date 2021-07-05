# frozen_string_literal: true

module Api
  module V1
    class ComicsController < ApplicationController
      def index
        comics_response = comics_list.fetch(query_params)
        render json: comics_response
      end

      private

      def comics_list
        ::ComicsList.new
      end

      def query_params
        params
          .permit(:title, :offset)
          .to_h
          .symbolize_keys
      end
    end
  end
end
