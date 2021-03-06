# frozen_string_literal: true

# User like class. Embedded inside book, contain user who liked book and value of like
class UsersLike
  include Mongoid::Document
  field :user_id, type: String
  field :score, type: Integer
  embedded_in :book

  validates :user_id, presence: true, uniqueness: true
  validates :score, presence: true, numericality: { only_integer: true, greater_than: 0, less_than: 6 }
end
