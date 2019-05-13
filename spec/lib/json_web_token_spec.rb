require 'rails_helper'
require 'json_web_token'

describe JsonWebToken do
  describe 'encodes and decodes' do
    let(:payload) { { user_id: 1 } }
    it 'returns back a given payload as hash' do
      token = described_class.encode(payload)

      expect(described_class.decode(token)).to eq(payload.with_indifferent_access)
    end
  end
end
