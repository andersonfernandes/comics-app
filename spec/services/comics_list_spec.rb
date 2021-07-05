# frozen_string_literal: true

require 'rails_helper'

describe ComicsList do
  describe '#fetch' do
    let(:comics_client) { instance_double(MarvelClient::Comics) }
    let(:comics_response) do
      {
        success: true,
        meta: { offset: 0, count: 20 },
        data: [
          {
            'id' => 1212,
            'title' => 'Comic 1',
            'issueNumber' => 12,
            'thumbnail' => {
              "path" => "http://example/image_00",
              "extension" => "jpg"
            }
          },
          {
            'id' => 1313,
            'title' => 'Comic 2',
            'issueNumber' => 13,
            'thumbnail' => {
              "path" => "http://example/image_01",
              "extension" => "jpg"
            }
          },
        ]
      }
    end

    before do
      allow(MarvelClient::Comics).to receive(:new).and_return(comics_client)
      allow(comics_client).to receive(:fetch)
        .with(kind_of(Hash)).and_return(comics_response)
    end

    it do
      expect(subject.fetch).to be_a(Hash)
    end

    it do
      custom_params = { offset: 12 }
      subject.fetch(custom_params)

      expect(comics_client).to have_received(:fetch).with(custom_params)
    end
  end
end
