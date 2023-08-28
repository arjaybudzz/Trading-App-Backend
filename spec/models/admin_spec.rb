require 'rails_helper'

RSpec.describe Admin, type: :model do
  describe 'username validation' do
    it { should validate_presence_of(:username) }
    it { should validate_uniqueness_of(:username) }
  end

  describe 'first name validation' do
    it { should validate_presence_of(:first_name) }
  end

  describe 'last name validation' do
    it { should validate_presence_of(:last_name) }
  end

  describe 'email validations' do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }

    context 'reject invalid email format' do
      invalid_email = %w[example @example example.com example@example]

      invalid_email.each do |email|
        it { should_not allow_value(email).for(:email) }
      end
    end
  end

  describe 'password validation' do
    it { should have_secure_password }
    it { should validate_length_of(:password).is_at_least(8).is_at_most(20) }
  end

  describe 'association test' do
    it { should have_many(:traders).dependent(:destroy) }
  end
end
