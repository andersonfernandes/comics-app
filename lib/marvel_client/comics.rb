# frozen_string_literal: true

module MarvelClient
  class Comics < Base
    def all
      response = client.get('comics') do |request|
        request.params['orderBy'] = '-onsaleDate'
      end

      http_response_to_struct(response.body)
    end
  end
end
