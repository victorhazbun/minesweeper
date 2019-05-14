require 'rails_helper'

RSpec.describe Game, type: :model do
  before do
    Timecop.freeze(Time.local(2019, 9, 1, 10, 5, 0))
  end

  after do
    Timecop.return
  end

  let(:user) { create(:user) }
  let(:now) { DateTime.current }

  describe 'belongs' do
    it { should belong_to(:user).required }
  end

  describe 'started at parsing' do
    context 'when record is new' do
      it 'sets started at from any string' do
        game = create(:game, user: user, started_at: now.iso8601)

        expect(game.started_at).to eq(now)
      end
    end

    context 'when record is persisted' do
      it 'sets started at from any string' do
        later = now + 1.hour
        game = create(:game, user: user, started_at: now.iso8601)
        game.update(started_at: later.iso8601)

        expect(game.started_at).to eq(later)
      end
    end
  end

  describe 'finished at parsing' do
    context 'when record is new' do
      it 'sets started at from any string' do
        later = now + 1.hour
        game = create(:game,
          user: user,
          started_at: now.iso8601,
          finished_at: later.iso8601
        )

        expect(game.finished_at).to eq(later)
      end
    end

    context 'when record is persisted' do
      it 'sets started at from any string' do
        later = now + 1.hour
        game = create(
          :game,
          user: user,
          started_at: now.iso8601
        )
        game.update(
          finished_at: later.iso8601
        )

        expect(game.finished_at).to eq(later)
      end
    end
  end

  describe 'rows validations' do
    it { is_expected.to validate_presence_of(:rows) }
  end

  describe 'cols validations' do
    it { is_expected.to validate_presence_of(:cols) }
  end

  describe 'started at is in the future validation' do
    it 'sets errors on started at' do
      game = build(
        :game,
        user: user,
        started_at: 1.hours.ago.iso8601
      )

      game.valid?

      expect(game.errors[:started_at]).to include('can not be in the past')
    end
  end

  describe 'finished at is after started at validation' do
    it 'sets errors on finished at' do
      game = build(
        :game,
        user: user,
        started_at: now.iso8601,
        finished_at: (now - 1.hour).iso8601
      )

      game.valid?

      expect(game.errors[:finished_at]).to include('can not be before started at')
    end
  end
end
