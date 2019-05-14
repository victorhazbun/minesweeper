FactoryBot.define do
  factory :game do
    started_at { Date.current }
    finished_at { 10.minutes.from_now }
    rows { 20 }
    cols { 20 }
  end
end