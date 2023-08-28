require 'rails_helper'

RSpec.describe 'Api::Tokens', type: :request do
  describe 'POST /create' do
    context 'generate admin token if input is valid' do
      let(:admin_login) { create(:admin) }

      before { post '/api/tokens', params: { admin: { email: admin_login.email, password: admin_login.password } }, as: :json }

      it { expect(json[:token].nil?).to eq(false) }
      it { expect(response).to have_http_status(:success) }
    end

    context 'do not generate admin token if input is invalid' do
      let(:invalid_admin_login) { create(:admin) }

      before { post '/api/tokens', params: { admin: { email: invalid_admin_login.email, password: 'wrong password' } }, as: :json }

      it { expect(response).to have_http_status(:unauthorized) }
    end
  end
end
