class Comment
  include Mongoid::Document
  field :body, type: String
  # field :user, type: String
  # field :book, type: String
  belongs_to :book
  belongs_to :user
end
