class LikedBook
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic
  field :book_id, type: String
  field :score, type: Integer

  embedded_in :user
  validates_uniqueness_of :book_id
end
