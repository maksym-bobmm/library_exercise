FactoryBot.define do
  factory :users_like do
    user
    book
    score { (1..5).to_a.sample }
  end
end
