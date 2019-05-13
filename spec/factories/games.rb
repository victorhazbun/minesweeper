FactoryBot.define do
  factory :game do
    started_at { Date.current }
    finished_at { 10.minutes.from_now }
  end
end