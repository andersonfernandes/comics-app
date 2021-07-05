# frozen_string_literal: true

require 'rails_helper'

describe ComicsController, type: :controller do
  describe '#index' do
    before { get :index }

    it { expect(response).to have_http_status(:ok) }
  end
end
