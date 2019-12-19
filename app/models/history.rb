# frozen_string_literal: true

# history class
class History
  include Mongoid::Document
  field :take_date, type: Time
  field :return_date, type: Time

  validates_presence_of :take_date

  belongs_to :book
  belongs_to :user
end
