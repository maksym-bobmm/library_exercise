class LikedBook
  include Mongoid::Document
  field :score, type: Integer

  embedded_in :user
end
