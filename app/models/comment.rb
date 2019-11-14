class Comment
  include Mongoid::Document
  include Mongoid::Timestamps
  field :body, type: String
  field :parent_id, type: String

  has_many :comments, class_name: 'Comment', foreign_key: 'parent_id'
  belongs_to :parent, class_name: 'Comment', optional: true
  belongs_to :book
  belongs_to :user
  scope :parents, -> { where(parent: nil) }
  scope :children, -> { where(:parent.exists => true) }


  # recursively_embeds_many
end
