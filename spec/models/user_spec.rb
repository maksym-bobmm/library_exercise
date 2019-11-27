require 'rails_helper'

RSpec.describe User, type: :model do
  it { is_expected.to be_mongoid_document }
  it { is_expected.to be_dynamic_document }

  context 'field' do
    %i[email encrypted_password reset_password_token username name].each do |field|
      it { is_expected.to have_field(field).of_type(String) }
    end
    %i[reset_password_sent_at remember_created_at].each do |field|
      it { is_expected.to have_field(field).of_type(Time) }
    end
  end

  context 'association' do
    it { is_expected.to have_many(:comments).with_dependent(:destroy) }
    it { is_expected.to have_many(:histories).with_dependent(:destroy) }
  end
end
