require 'rails_helper'

describe MarvelClient::Utils::JsonParser do
  subject { MockClient.new }

  describe '#http_response_to_struct' do
    context 'with a success and valid response' do
      let(:success_response_json) do
        {
          code: 200,
          data: {
            offset: 0,
            count: 1,
            results: [{ foo: 'bar' }]
          }
        }.to_json
      end

      let(:result) { subject.http_response_to_struct(success_response_json) }

      it { expect(result).to be_a(OpenStruct) }
      it { expect(result.success).to be_truthy }
      it { expect(result.meta).to eq({ offset: 0, count: 1 }) }
      it { expect(result.data).to eq [{ 'foo' => 'bar' }] }
    end

    context 'with an invalid response' do
      let(:invalid_response_json) { '' }

      let(:result) { subject.http_response_to_struct(invalid_response_json) }

      it { expect(result.success).to be_falsey }
      it { expect(result.meta).to eq({ offset: -1, count: 0 }) }
      it { expect(result.data).to be_empty }
    end

    context 'with an failed response' do
      let(:failed_response_json) { { code: 400 }.to_json }

      let(:result) { subject.http_response_to_struct(failed_response_json) }

      it { expect(result.success).to be_falsey }
      it { expect(result.meta).to eq({ offset: -1, count: 0 }) }
      it { expect(result.data).to be_empty }
    end
  end

  describe '#success_response?' do
    context 'with a success response' do
      let(:success_response) { { 'code' => 200 } }

      it { expect(subject.success_response?(success_response)).to be_truthy }
    end

    context 'with an failed response' do
      let(:failed_response) { { 'code' => 400 } }

      it { expect(subject.success_response?(failed_response)).to be_falsey }
    end
  end

  describe '#extract_response_data' do
    let(:response) do
      {
        'data' => {
          'offset' => 0,
          'count' => 20,
          'results' => [{ foo: 'bar' }]
        }
      }
    end

    it 'should return an array with the metadata and data' do
      expected_result = [
        { offset: 0, count: 20 },
        [{ foo: 'bar' }]
      ]

      expect(subject.extract_response_data(response)).to eq(expected_result)
    end
  end

  describe '#valid_response?' do
    context 'with a valid response' do
      let(:response) do
        {
          'data' => {
            'offset' => 0,
            'count' => 20,
            'results' => [{ foo: 'bar' }]
          }
        }
      end

      it { expect(subject.valid_response?(response)).to be_truthy }
    end

    context 'when the data key is missing' do
      let(:response) { {} }

      it { expect(subject.valid_response?(response)).to be_falsey }
    end

    context 'when the results key is missing' do
      let(:response) { { data: {} } }

      it { expect(subject.valid_response?(response)).to be_falsey }
    end
  end

  describe '#error_struct' do
    let(:error_struct) { subject.error_struct }

    it { expect(error_struct.success).to be_falsey }
    it { expect(error_struct.meta).to eq({ offset: -1, count: 0 }) }
    it { expect(error_struct.data).to be_empty }
  end
end

class MockClient
  include ::MarvelClient::Utils::JsonParser
end
