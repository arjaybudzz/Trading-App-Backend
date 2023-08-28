require 'rails_helper'

RSpec.describe 'Api::Admins', type: :request do
  describe 'GET /show' do
    let(:admin_sample) { create(:admin) }

    before { get "/api/admins/#{admin_sample.id}", as: :json }

    it { expect(json[:data][:attributes][:email]).to match(admin_sample.email) }
    it { expect(response).to have_http_status(:success) }
  end

  describe 'POST /create' do
    context 'create admin account if input is valid' do
      let(:admin_params) { attributes_for(:admin) }

      before { post '/api/admins', params: { admin: admin_params }, as: :json }

      it { expect(response).to have_http_status(:created) }
    end

    context 'do not create admin account if input is invalid' do
      let(:invalid_params) { attributes_for(:empty_email) }

      before { post '/api/admins', params: { admin: invalid_params }, as: :json }

      it { expect(response).to have_http_status(:unprocessable_entity) }
    end
  end

  describe 'PUT /update' do
    context 'update admin info if input is valid' do
      let(:admin_test) { create(:admin) }
      let(:update_params) { attributes_for(:admin) }

      before do
        put "/api/admins/#{admin_test.id}", params: { admin: update_params },
                                            headers: { Authorization: JsonWebToken.encode(admin_id: admin_test.id) }, as: :json
      end

      it { expect(response).to have_http_status(:success) }
    end

    context 'do not update admin info if input is invalid' do
      let(:admin_test) { create(:admin) }
      let(:update_params) { attributes_for(:admin) }

      before { put "/api/admins/#{admin_test.id}", params: { admin: update_params }, as: :json }

      it { expect(response).to have_http_status(:forbidden) }
    end
  end

  describe 'DELETE /destroy' do
    context 'delete admin if authorized' do
      let(:admin_test) { create(:admin) }

      before do
        delete "/api/admins/#{admin_test.id}", headers: { Authorization: JsonWebToken.encode(admin_id: admin_test.id) }, as: :json
      end

      it { expect(response).to have_http_status(:no_content) }
    end

    context 'forbid to delete if unauthorized' do
      let(:admin_test) { create(:admin) }

      before { delete "/api/admins/#{admin_test.id}", as: :json }

      it { expect(response).to have_http_status(:forbidden) }
    end
  end
end
