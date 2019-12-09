# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
(1..50).each do
  Book.create(name: Faker::Book.title,
              description: Faker::Lorem.paragraph(sentence_count: 5, supplemental: true, random_sentences_to_add: 20),
              author: Faker::Book.author,
              remote_avatar_url: Faker::Avatar.image( size: "450x450" ) )
end