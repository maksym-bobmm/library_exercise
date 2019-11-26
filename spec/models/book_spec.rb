require 'rails_helper'

RSpec.describe Book, type: :model do
  it { is_expected.to be_mongoid_document }
  context 'fields' do
    %i[name description author avatar].each do |field|
      it { is_expected.to have_field(field).of_type(String) }
    end
    it { is_expected.to have_field(:state).of_type(Boolean).with_default_value_of(true) }
    it { is_expected.to have_field(:taken_count).of_type(Integer).with_default_value_of(0) }
  end
  context 'validation' do
    %i[name description author state].each do |field|
      it { is_expected.to validate_presence_of(field) }
    end
  end
  context 'association' do
    it { is_expected.to have_many(:comments) }
    it { is_expected.to mongoid_have_many(:histories).with_dependent(:destroy) }
    it { is_expected.to embeds_many(:users_likes) }
  end
end
