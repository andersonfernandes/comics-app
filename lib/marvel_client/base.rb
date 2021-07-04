# frozen_string_literal: true

module MarvelClient
  class Base
    include Utils::JsonParser

    def initialize
      @base_url = ENV['MARVEL_API_BASE_URL']
      @public_key = ENV['MARVEL_PUBLIC_KEY']
      @private_key = ENV['MARVEL_PRIVATE_KEY']
    end

    private

    def client
      @connection = Faraday.new(
        url: @base_url,
        params: auth_params,
        headers: { 'Content-Type' => 'application/json' }
      )
    end

    def auth_params
      timestamp = Time.now.to_i
      hash_base = "#{timestamp}#{@private_key}#{@public_key}"
      hash = Digest::MD5.hexdigest(hash_base)

      {
        ts: timestamp,
        apikey: @public_key,
        hash: hash
      }
    end
  end
end
