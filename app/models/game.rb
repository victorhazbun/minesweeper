class Game < ApplicationRecord
  belongs_to :user

  before_validation :set_started_at
  before_validation :set_finished_at
  validates :started_at, presence: true
  validates :rows, presence: true
  validates :cols, presence: true
  validate :started_at_is_future, if: :started_at?
  validate :finished_at_is_after_started_at, if: -> { started_at? && finished_at? }

  def set_started_at
    self.started_at = Chronic.parse(started_at&.to_s)
  end

  def set_finished_at
    self.finished_at = Chronic.parse(finished_at&.to_s)
  end

  private

  def started_at_is_future
    errors.add(:started_at, I18n.t('errors.can_not_be_past')) if started_at < DateTime.current
  end

  def finished_at_is_after_started_at
    errors.add(:finished_at, I18n.t('errors.can_not_be_before_started_at')) if finished_at < started_at
  end
end
