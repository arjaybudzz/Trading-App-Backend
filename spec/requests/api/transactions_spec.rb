require 'rails_helper'

RSpec.describe 'Api::Transactions', type: :request do

  setup do
    @trader_sample = create(:trader)

    @ticker_sample = create(:ticker)

    @transaction_sample = create(:transaction)
    @another_transaction_sample = create(:transaction)

    @transaction_params_buyer = attributes_for(:transaction)
    @transaction_params_seller = attributes_for(:transaction, :seller)
    @invalid_transaction_params = attributes_for(:transaction, :empty_stock_name)
  end

  describe 'GET /index' do
    before do
      create_list(:transaction, 10)
      get '/api/transactions', as: :json
    end

    it { expect(response).to have_http_status(:success) }
  end

  describe 'GET /show' do
    before do
      get "/api/transactions/#{@transaction_sample.id}", as: :json
    end

    it { expect(json[:data][:attributes][:stock]).to match(@transaction_sample.stock) }
    it { expect(response).to have_http_status(:success) }
  end

  describe 'POST /create' do
    context 'create a buy transaction and activate StockComputingApi.buy_profit' do
      before do
        post '/api/transactions', params: { transaction: @transaction_params_buyer },
                                  headers: { Authorization: JsonWebToken.encode(ticker_id: @ticker_sample.id) },
                                  as: :json
      end

      it { expect(response).to have_http_status(:created) }
      it { expect(StockComputingApi.buy_profit(@ticker_sample, @transaction_sample, @trader_sample)).to eq(true) }
    end

    context 'create a sell transaction and activate StockComputingApi.sell_profit' do
      before do
        post '/api/transactions', params: { transaction: @transaction_params_seller },
                                  headers: { Authorization: JsonWebToken.encode(ticker_id: @ticker_sample.id) },
                                  as: :json
      end

      it { expect(response).to have_http_status(:created) }
      it { expect(StockComputingApi.sell_profit(@ticker_sample, @transaction_sample, @trader_sample)).to eq(true) }
    end

    context 'do not create transaction if stock name is invalid' do
      before do
        post '/api/transactions', params: { transaction: @invalid_transaction_params },
                                  headers: { Authorization: JsonWebToken.encode(ticker_id: @ticker_sample.id) }, as: :json
      end

      it { expect(response).to have_http_status(:unprocessable_entity) }

    end

    context 'forbid to transact if there is no stock selected' do
      before do
        post '/api/transactions', params: { transaction: @transaction_params }, as: :json
      end

      it { expect(response).to have_http_status(:forbidden) }
    end
  end

  describe 'DELETE /destroy' do
    context 'delete transaction if authorized' do
      before do
        delete "/api/transactions/#{@transaction_sample.id}", headers: { Authorization: JsonWebToken.encode(ticker_id: @transaction_sample.ticker_id) }, as: :json
      end

      it { expect(response).to have_http_status(:no_content) }
    end

    context 'forbid delete transaction if unauthorized' do
      before do
        delete "/api/transactions/#{@transaction_sample.id}", headers: { Authorization: JsonWebToken.encode(ticker_id: @another_transaction_sample.ticker_id) }, as: :json
      end

      it { expect(response).to have_http_status(:forbidden) }
    end
  end
end
