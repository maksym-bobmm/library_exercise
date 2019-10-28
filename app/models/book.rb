class Book
  include Mongoid::Document
  field :name, type: String
  field :description, type: String
  field :likes, type: Integer
  field :state, type: Boolean
  field :rating, type: Integer
end
