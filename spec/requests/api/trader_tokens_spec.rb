require 'rails_helper'

RSpec.describe 'Api::TraderTokens', type: :request do
  describe 'POST /create' do
    context "return a trader's token if input is valid" do
      let(:trader_sample) { create(:trader) }

      before do
        post '/api/trader_tokens', params: { trader: { email: trader_sample.email, password: trader_sample.password } }, as: :json
      end

      it { expect(json[:trader_token].nil?).to eq(false) }
      it { expect(response).to have_http_status(:success) }
    end

    context "do not return trader's token if input is invalid" do
      let(:trader_sample) { create(:trader) }

      before do
        post '/api/trader_tokens', params: { trader: { email: trader_sample.email,
                                                       password: 'bad password' } },
                                                       as: :json
      end

      it { expect(response).to have_http_status(:unauthorized) }
    end
  end
end
