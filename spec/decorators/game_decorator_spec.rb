require 'rails_helper'

RSpec.describe GameDecorator do
  context 'when game have started at and finished at' do
    let(:now) { DateTime.current }
    let(:game) do
      build(:game,
        started_at: now,
        finished_at: now + 1.hour
      )
    end

    it 'returns the decorated time elapsed in words' do
      expect(described_class.new(game).time_in_words).to eq('about 1 hour')
    end
  end

  context 'when game does not have started at' do
    let(:game) do
      build(:game,
        started_at: nil,
        finished_at: 2.minutes.from_now
      )
    end

    it 'returns nothing' do
      expect(game.decorate.time_in_words).to be_nil
    end
  end

  context 'when game does not have finished at' do
    let(:game) do
      build(:game,
        started_at: Date.current,
        finished_at: nil
      )
    end
    it 'returns nothing' do
      expect(game.decorate.time_in_words).to be_nil
    end
  end

  context 'when game does not have started at or finished at' do
    let(:game) do
      build(:game,
        started_at: nil,
        finished_at: nil
      )
    end
    it 'returns nothing' do
      expect(game.decorate.time_in_words).to be_nil
    end
  end
end
