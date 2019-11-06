class User
  include Mongoid::Document
  field :name, type: String
  field :email, type: String
  has_many :comments
  has_many :histories
end
