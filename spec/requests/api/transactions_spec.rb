require 'rails_helper'

RSpec.describe 'Api::Transactions', type: :request do
  describe 'GET /index' do
    before do
      create_list(:transaction, 10)
      get '/api/transactions', as: :json
    end

    it { expect(response).to have_http_status(:success) }
  end

  describe 'GET /show' do
    let(:transaction_sample) { create(:transaction) }

    before do
      get "/api/transactions/#{transaction_sample.id}", as: :json
    end

    it { expect(json[:data][:attributes][:stock]).to match(transaction_sample.stock) }
    it { expect(response).to have_http_status(:success) }
  end

  describe 'POST /create' do
    context 'transaction occurs if there is a stock selected' do
      let(:ticker_sample) { create(:ticker) }
      let(:transaction_params) { attributes_for(:transaction) }

      before do
        post '/api/transactions', params: { transaction: transaction_params },
                                  headers: { Authorization: JsonWebToken.encode(ticker_id: ticker_sample.id) }, as: :json
      end

      it { expect(response).to have_http_status(:created) }
    end

    context 'forbid to transact if there is not stock selected' do
      let(:transaction_params) { attributes_for(:transaction) }

      before do
        post '/api/transactions', params: { transaction: transaction_params }, as: :json
      end

      it { expect(response).to have_http_status(:forbidden) }
    end
  end

  describe 'DELETE /destroy' do
    context 'delete transaction if authorized' do
      let(:transaction_sample) { create(:transaction) }

      before do
        delete "/api/transactions/#{transaction_sample.id}", headers: { Authorization: JsonWebToken.encode(ticker_id: transaction_sample.ticker_id) }, as: :json
      end

      it { expect(response).to have_http_status(:no_content) }
    end

    context 'forbid delete transaction if unauthorized' do
      let(:transaction_sample) { create(:transaction) }
      let(:another_transaction_sample) { create(:transaction) }

      before do
        delete "/api/transactions/#{transaction_sample.id}", headers: { Authorization: JsonWebToken.encode(ticker_id: another_transaction_sample.ticker_id) }, as: :json
      end

      it { expect(response).to have_http_status(:forbidden) }
    end
  end

end
