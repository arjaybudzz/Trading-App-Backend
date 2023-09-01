require 'rails_helper'

RSpec.describe 'Api::TickerTokens', type: :request do
  describe 'POST /create' do
    context 'generate a ticker token if a ticker exists' do
      let(:ticker_sample) { create(:ticker) }

      before do
        post '/api/ticker_tokens', params: { ticker: { symbol: ticker_sample.symbol } }, as: :json
      end

      it { expect(json[:ticker_token].nil?).to eq(false) }
      it { expect(response).to have_http_status(:success) }
    end

    context 'do not generate ticker token if argument is invalid' do
      before do
        post '/api/ticker_tokens', params: { ticker: { symbol: "" } }, as: :json
      end

      it { expect(response).to have_http_status(:unauthorized) }
    end
  end
end
