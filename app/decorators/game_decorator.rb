class GameDecorator < Draper::Decorator
  delegate_all

  def started_at
    object.started_at&.iso8601
  end

  def finished_at
    object.finished_at&.iso8601
  end

  def time_in_words
    return unless object.finished_at
    h.distance_of_time_in_words(
      object.started_at,
      object.finished_at,
      include_seconds: true
    )
  end
end
