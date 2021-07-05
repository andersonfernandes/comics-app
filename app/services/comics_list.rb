# frozen_string_literal: true

class ComicsList
  def fetch(params = {})
    response = comics_client.fetch(params)

    response.tap do |resp|
      resp[:data] = resp[:data].map do |comic|
        cover_path = comic['thumbnail']['path']
        cover_extension = comic['thumbnail']['extension']
        cover_url = "#{cover_path}/portrait_uncanny.#{cover_extension}"

        {
          id: comic['id'],
          title: comic['title'],
          issue_number: comic['issueNumber'],
          cover_url: cover_url
        }
      end
    end
  end

  private

  def comics_client
    @comics_client = ::MarvelClient::Comics.new
  end
end
