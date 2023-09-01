require 'rails_helper'

RSpec.describe 'Api::Admins', type: :request do

  setup do
    @admin_sample = create(:admin)
    @admin_params = attributes_for(:admin)
    @invalid_admin_params = attributes_for(:empty_email)
  end

  describe 'GET /show' do
    before { get "/api/admins/#{@admin_sample.id}", as: :json }

    it { expect(json[:data][:attributes][:email]).to match(@admin_sample.email) }
    it { expect(response).to have_http_status(:success) }
  end

  describe 'POST /create' do
    context 'create admin account if input is valid' do
      before { post '/api/admins', params: { admin: @admin_params }, as: :json }

      it { expect(response).to have_http_status(:created) }
    end

    context 'do not create admin account if input is invalid' do
      before { post '/api/admins', params: { admin: @invalid_admin_params }, as: :json }

      it { expect(response).to have_http_status(:unprocessable_entity) }
    end
  end

  describe 'PUT /update' do
    context 'update admin info if input is valid' do
      before do
        put "/api/admins/#{@admin_sample.id}", params: { admin: @admin_params },
                                               headers: { Authorization: JsonWebToken.encode(admin_id: @admin_sample.id) },
                                               as: :json
      end
      it { expect(response).to have_http_status(:success) }
    end

    context 'do not update admin info if new values in invalid' do
      before do
        put "/api/admins/#{@admin_sample.id}", params: { admin: @invalid_admin_params },
                                               headers: { Authorization: JsonWebToken.encode(admin_id: @admin_sample.id) },
                                               as: :json
      end

      it { expect(response).to have_http_status(:unprocessable_entity) }
    end

    context 'do not update admin info if unauthorized' do
      before do
        put "/api/admins/#{@admin_sample.id}", params: { admin: @admin_params }, as: :json
      end

      it { expect(response).to have_http_status(:forbidden) }
    end
  end

  describe 'DELETE /destroy' do
    context 'delete admin if authorized' do
      before do
        delete "/api/admins/#{@admin_sample.id}",
        headers: { Authorization: JsonWebToken.encode(admin_id: @admin_sample.id) },
        as: :json
      end

      it { expect(response).to have_http_status(:no_content) }
    end

    context 'forbid to delete if unauthorized' do
      before { delete "/api/admins/#{@admin_sample.id}", as: :json }
      it { expect(response).to have_http_status(:forbidden) }
    end
  end
end
