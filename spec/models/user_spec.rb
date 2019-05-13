require 'rails_helper'

describe User, type: :model do
  describe 'have secure password' do
    it { is_expected.to have_secure_password }
  end

  describe 'email validations' do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:email) }
    it { is_expected.to allow_value('victor@domain.com').for(:email) }
    it { is_expected.not_to allow_value('victor@@domain.com').for(:email) }
  end

  describe 'password validations' do
    it { is_expected.to validate_length_of(:password).is_at_least(6).on(:create) }
  end

  describe '.by_lower_email named scope' do
    it 'returns users filtered by lower case email' do
      user_a = create(:user, email: 'JHON@example.com')
      user_b = create(:user, email: 'Larry@example.com')

      expect(
        described_class.by_lower_email('jhon@example.com')
      ).to include(user_a)

      expect(
        described_class.by_lower_email('jhon@example.com')
      ).to_not include(user_b)
    end
  end
end
