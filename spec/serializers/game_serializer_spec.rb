require 'rails_helper'

RSpec.describe GameSerializer do
  before do
    Timecop.freeze(Time.local(2019, 9, 1, 10, 5, 0))
  end

  after do
    Timecop.return
  end

  let(:now) { DateTime.current }

  context 'when game have started at and finished at' do
    let(:game) do
      create(:game,
        started_at: now,
        finished_at: now + 1.hour,
        user: create(:user)
      )
    end

    it 'returns serialized game' do
      expect(described_class.new(game.decorate).serialized_json).to include_json(
        data: {
          id: game.id.to_s,
          type: 'game',
          attributes: {
            started_at: '2019-09-01T15:05:00Z',
            finished_at: '2019-09-01T16:05:00Z',
            time_in_words: 'about 1 hour'
          }
        }
      )
    end
  end

  context 'when game does not have finished at' do
    let(:game) do
      create(:game,
        started_at: now,
        finished_at: nil,
        user: create(:user)
      )
    end

    it 'returns serialized game' do
      expect(described_class.new(game.decorate).serialized_json).to include_json(
        data: {
          id: game.id.to_s,
          type: 'game',
          attributes: {
            started_at: '2019-09-01T15:05:00Z',
            finished_at: nil
          }
        }
      )
    end
  end
end
