# frozen_string_literal: true

module MarvelClient
  class Comics < Base
    DEFAULT_QUERY = { title: nil, offset: 0, limit: 20 }.freeze

    def fetch(query = {})
      query = DEFAULT_QUERY.merge(query)

      response = client.get('comics') do |request|
        request.params['orderBy'] = '-onsaleDate'
        request.params['limit'] = query[:limit]
        request.params['offset'] = query[:offset]
        request.params['title'] = query[:title] unless query[:title].nil?
      end

      http_response_to_struct(response.body)
    end
  end
end
