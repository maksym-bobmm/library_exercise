# frozen_string_literal: true

FactoryBot.define do
  factory :history_take_only, class: History do
    take_date { Time.now }
    user { create(:user) }
    book { create(:book) }

    factory :history_with_return, class: History do
      return_date { Time.now }
    end
  end
end
