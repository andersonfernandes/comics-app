# frozen_string_literal: true

module MarvelClient
  module Utils
    module JsonParser
      # TODO: Add Log on failed requests or exceptions
      def http_response_to_struct(http_response)
        response_hash = JSON.parse(http_response)
        success = success_response?(response_hash)

        return error_struct unless success && valid_response?(response_hash)

        meta, data = extract_response_data(response_hash)
        OpenStruct.new(success: success, meta: meta, data: data)
      rescue JSON::ParserError
        error_struct
      end

      def success_response?(response_hash)
        status_code = response_hash['code']

        status_code == 200
      end

      def extract_response_data(response_hash)
        response_data = response_hash['data']
        data = response_data.fetch('results', [])
        meta = {
          offset: response_data['offset'],
          count: response_data['count']
        }

        [meta, data]
      end

      def valid_response?(response_hash)
        data_key_present = response_hash.key?('data')
        results_key_present = response_hash.fetch('data', {}).key?('results')

        data_key_present && results_key_present
      end

      def error_struct
        OpenStruct.new(success: false, meta: { offset: -1, count: 0 }, data: [])
      end
    end
  end
end
