FactoryBot.define do
  factory :book do
    name { Faker::Book.title }
    description { Faker::Lorem.paragraph(sentence_count: 5, supplemental: true, random_sentences_to_add: 20) }
    author { Faker::Book.author }
    state { 0 }
  end
end