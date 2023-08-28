require 'rails_helper'

RSpec.describe "Api::Tickers", type: :request do
  describe "GET /index" do
    before do
      create_list(:ticker, 15)
      get '/api/tickers', as: :json
    end

    it { expect(response).to have_http_status(:success) }
  end

  describe 'GET /show' do
    let(:ticker_sample) { create(:ticker) }

    before do
      get "/api/tickers/#{ticker_sample.id}", as: :json
    end

    it { expect(json[:data][:attributes][:symbol]).to match(ticker_sample.symbol) }
    it { expect(response).to have_http_status(:success) }
  end

  describe 'POST /create' do
    context 'create ticker if authorized' do
      let(:ticker_attributes) { attributes_for(:ticker) }
      let(:ticker_sample) { create(:ticker) }

      before do
        post '/api/tickers', params: { ticker: ticker_attributes },
                            headers: { Authorization: JsonWebToken.encode(trader_id: ticker_sample.trader_id) }, as: :json
      end

      it { expect(response).to have_http_status(:created) }
    end

    context 'forbid create ticker if unauthorized' do
      let(:ticker_attributes) { attributes_for(:ticker) }

      before do
        post '/api/tickers', params: { ticker: ticker_attributes }, as: :json
      end

      it { expect(response).to have_http_status(:forbidden) }
    end
  end

  describe 'PUT /update' do
    context 'update ticker if authorized' do
      let(:ticker_sample) { create(:ticker) }
      let(:ticker_attributes) { attributes_for(:ticker) }

      before do
        put "/api/tickers/#{ticker_sample.id}", params: { ticker: ticker_attributes },
                                                headers: { Authorization: JsonWebToken.encode(trader_id: ticker_sample.trader_id) },
                                                as: :json
      end

      it { expect(response).to have_http_status(:success) }
    end

    context 'forbid update ticker if unauthorized' do
      let(:ticker_attributes) { attributes_for(:ticker) }
      let(:ticker_sample) { create(:ticker) }
      let(:another_ticker_sample) { create(:ticker) }

      before do
        put "/api/tickers/#{ticker_sample.id}", params: { ticker: ticker_attributes },
                                               headers: { Authorization: JsonWebToken.encode(trader_id: another_ticker_sample.trader_id) }
      end

      it { expect(response).to have_http_status(:forbidden) }
    end
  end

  describe 'DELETE /destroy' do
    context 'delete ticker if authorized' do
      let(:ticker_sample) { create(:ticker) }

      before do
        delete "/api/tickers/#{ticker_sample.id}", headers: { Authorization: JsonWebToken.encode(trader_id: ticker_sample.trader_id) }, as: :json
      end

      it { expect(response).to have_http_status(:no_content) }
    end

    context 'forbid to delete if unauthorized' do
      let(:ticker_sample) { create(:ticker) }
      let(:another_ticker_sample) { create(:ticker) }

      before do
        delete "/api/tickers/#{ticker_sample.id}", headers: { Authorization: JsonWebToken.encode(trader_id: another_ticker_sample.trader_id) }, as: :json
      end

      it { expect(response).to have_http_status(:forbidden) }
    end
  end
end
