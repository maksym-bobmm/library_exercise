class History
  include Mongoid::Document
  field :take_date, type: Time
  field :return_date, type: Time
  belongs_to :user
  belongs_to :book
end
