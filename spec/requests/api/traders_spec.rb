require 'rails_helper'

RSpec.describe 'Api::Traders', type: :request do
  setup do
    @trader_sample = create(:trader)
    @trader_params = attributes_for(:trader)
  end

  describe 'GET /index' do
    before do
      create_list(:trader, 10)
      get '/api/traders', as: :json
    end

    it { expect(response).to have_http_status(:success) }
  end

  describe 'GET /show' do

    before do
      get "/api/traders/#{@trader_sample.id}", as: :json
    end

    it { expect(json[:data][:attributes][:email]).to match(@trader_sample.email) }
    it { expect(response).to have_http_status(:success) }
  end

  describe 'POST /create' do
    context 'create a trader if there is existing admin' do
      before do
        post '/api/traders', params: { trader: @trader_params },
                             headers: { Authorization: JsonWebToken.encode(admin_id: @trader_sample.admin_id) },
                             as: :json
      end

      it { expect(response).to have_http_status(:created) }
    end

    context 'forbid to create a user if there is no existing admin' do
      before do
        post '/api/traders', params: { trader: @trader_params }, as: :json
      end

      it { expect(response).to have_http_status(:forbidden) }
    end
  end

  describe 'PUT /update' do
    context 'update information if authorized' do
      let(:update_attributes) { attributes_for(:trader) }

      before do
        put "/api/traders/#{@trader_sample.id}", params: { trader: update_attributes },
                                                headers: { Authorization: JsonWebToken.encode(admin_id: @trader_sample.admin_id) },
                                                as: :json
      end

      it { expect(response).to have_http_status(:success) }
    end

    context 'forbid update if unauthorized' do
      let(:another_trader) { create(:trader) }
      let(:update_attributes) { attributes_for(:trader) }

      before do
        put "/api/traders/#{@trader_sample.id}", params: { trader: update_attributes },
                                                 headers: { Authorization: JsonWebToken.encode(admin_id: another_trader.admin_id) },
                                                 as: :json
      end

      it { expect(response).to have_http_status(:forbidden) }
    end
  end

  describe 'DELETE /destroy' do
    context 'allow delete if authorized' do
      before do
        delete "/api/traders/#{@trader_sample.id}", headers: { Authorization: JsonWebToken.encode(admin_id: @trader_sample.admin_id) }, as: :json
      end

      it { expect(response).to have_http_status(:no_content) }
    end

    context 'forbid delete if unauthorized' do
      let(:another_trader) { create(:trader) }

      before do
        delete "/api/traders/#{@trader_sample.id}", headers: { Authorization: JsonWebToken.encode(admin_id: another_trader.admin_id) }, as: :json
      end

      it { expect(response).to have_http_status(:forbidden) }
    end
  end
end
