# frozen_string_literal: true

FactoryBot.define do
  factory :book do
    name { Faker::Book.title }
    description { Faker::Lorem.paragraph(sentence_count: 5, supplemental: true, random_sentences_to_add: 20) }
    author { Faker::Book.author }
    state { true }

    factory :book_with_like do
      users_likes { [create(:users_likes, user)] }
    end
    factory :book_with_image do
      remote_avatar_url { Faker::Avatar.image(size: '450x450') }
    end
  end
end
