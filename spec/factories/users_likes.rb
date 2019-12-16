FactoryBot.define do
  factory :users_like do
    user { create(:user) }
    score { (1..5).to_a.sample }
  end
end
