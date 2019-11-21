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

  has_many :comments
  has_many :histories, dependent: :destroy
  embeds_many :users_likes

  def likes_sum
    users_likes.sum(:score)
  end
  def rating
    return 0 if users_likes.size == 0

    likes_sum / users_likes.size
  end
end
