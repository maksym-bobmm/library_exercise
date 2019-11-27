require 'rails_helper'

RSpec.describe UsersLike, type: :model do
  it { is_expected.to be_mongoid_document }
  context 'fields' do
    it { is_expected.to have_field(:user_id).of_type(String) }
    it { is_expected.to have_field(:score).of_type(Integer) }
  end
  context 'association' do
    it { is_expected.to be_embedded_in(:book) }
  end
  context 'validation' do
    it { is_expected.to validate_presence_of(:user_id) }
    it { is_expected.to validate_uniqueness_of(:user_id) }
    it { is_expected.to validate_presence_of(:score) }
    it { is_expected.to validate_numericality_of(:score).greater_than(0).less_than(6) }
  end
end
