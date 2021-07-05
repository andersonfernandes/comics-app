# frozen_string_literal: true

require 'rails_helper'

describe Api::V1::ComicsController, type: :controller do
  describe '#index' do
    let(:comics_list_service) { instance_double(ComicsList) }

    before do
      allow(ComicsList).to receive(:new).and_return(comics_list_service)
      allow(comics_list_service).to receive(:fetch)
        .with(kind_of(Hash)).and_return([double, double])
    end

    context 'when given no params' do
      before { get :index }

      it { expect(response).to have_http_status(:ok) }
      it { expect(comics_list_service).to have_received(:fetch).with({}) }
    end

    context 'when given some params' do
      let(:params) { { title: 'Comic 1', offset: '3' } }

      before { get :index, params: params }

      it { expect(response).to have_http_status(:ok) }
      it { expect(comics_list_service).to have_received(:fetch).with(params) }
    end
  end
end
