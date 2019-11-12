class Book
  include Mongoid::Document
  field :name, type: String
  field :description, type: String
  field :author, type: String
  field :state, type: Boolean, default: false
  field :taken_count, type: Integer, default: 0

  validates_presence_of :name, :description, :author

  has_many :comments
  has_many :histories
  embeds_many :users_likes
end
