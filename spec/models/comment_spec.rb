# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Comment, type: :model do
  it { is_expected.to be_mongoid_document }
  it { is_expected.to have_timestamps }

  context 'field' do
    it { is_expected.to have_field(:body).of_type(String) }
    it { is_expected.to have_field(:parent_id).of_type(Object) }
  end

  context 'association' do
    it { is_expected.to have_many(:comments).with_foreign_key('parent_id').with_dependent(:destroy) }
    %i[parent user book].each do |field|
      it { is_expected.to belong_to(field) }
    end
  end
end
