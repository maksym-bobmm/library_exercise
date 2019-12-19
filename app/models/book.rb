# frozen_string_literal: true

# Book class
class Book
  include Mongoid::Document
  mount_uploader :avatar, AvatarUploader
  field :name, type: String
  field :description, type: String
  field :author, type: String
  field :state, type: Boolean, default: true
  field :taken_count, type: Integer, default: 0
  field :avatar, type: String

  validates_presence_of :name, :description, :author, :state
  validates :taken_count, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  has_many :comments, dependent: :destroy
  has_many :histories, dependent: :destroy
  embeds_many :users_likes

  def likes_sum
    users_likes.sum(:score)
  end

  def rating
    return 0 if users_likes.size.zero?

    likes_sum / users_likes.size.to_f
  end
end
