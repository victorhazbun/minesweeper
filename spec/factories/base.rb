FactoryBot.define do
  sequence :email do |n|
    "name+#{n}@domain.com"
  end

  sequence :password do |n|
    "password-#{n}"
  end
end
