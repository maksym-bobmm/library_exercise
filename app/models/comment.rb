class Comment
  include Mongoid::Document
  field :body, type: String
  field :user, type: String
  field :book, type: String
end
