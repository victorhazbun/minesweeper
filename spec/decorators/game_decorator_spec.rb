require 'rails_helper'

RSpec.describe GameDecorator do
  before do
    Timecop.freeze(Time.local(2019, 9, 1, 10, 5, 0))
  end

  after do
    Timecop.return
  end

  let(:now) { DateTime.current }

  context 'when game have started at and finished at' do
    let(:game) do
      build(:game,
        started_at: now,
        finished_at: now + 1.hour
      )
    end

    it 'returns the decorated time elapsed in words' do
      expect(game.decorate.time_in_words).to eq('about 1 hour')
    end

    it 'returns the decorated started_at' do
      expect(game.decorate.started_at).to eq('2019-09-01T15:05:00Z')
    end

    it 'returns the decorated finished_at' do
      expect(game.decorate.finished_at).to eq('2019-09-01T16:05:00Z')
    end
  end

  context 'when game does not have finished at' do
    let(:game) do
      build(:game,
        started_at: now,
        finished_at: nil
      )
    end

    it 'returns nothing as the decorated time elapsed in words' do
      expect(game.decorate.time_in_words).to be_nil
    end

    it 'returns the decorated started_at' do
      expect(game.decorate.started_at).to eq('2019-09-01T15:05:00Z')
    end

    it 'returns the decorated finished_at' do
      expect(game.decorate.finished_at).to be_nil
    end
  end
end
