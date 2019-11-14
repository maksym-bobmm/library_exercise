class History
  include Mongoid::Document
  field :take_date, type: Time
  field :return_date, type: Time

  belongs_to :book
  belongs_to :user
end
