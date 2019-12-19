# frozen_string_literal: true

FactoryBot.define do
  factory :comment do
    body { Faker::Lorem.paragraph(sentence_count: 5, supplemental: true, random_sentences_to_add: 10)}
    user
    book
  end
end
