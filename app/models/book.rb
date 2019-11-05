class Book
  include Mongoid::Document
  field :name, type: String
  field :description, type: String
  field :author, type: String
  field :likes, type: Integer, default: 0
  field :state, type: Boolean, default: false
  field :rating, type: Float, default: 0

  validates_presence_of :name, :description
end
