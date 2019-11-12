class UsersLike
  include Mongoid::Document
  field :user_id, type: String
  field :score, type: Integer
  embedded_in :book

  validates_uniqueness_of :user_id
end
