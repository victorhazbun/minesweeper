class GameSerializer
  include FastJsonapi::ObjectSerializer

  attributes :started_at, :finished_at
  attribute :time_in_words, if: Proc.new { |record|
    record.finished_at
  }
end
