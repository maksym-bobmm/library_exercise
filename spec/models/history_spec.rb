# frozen_string_literal: true

require 'rails_helper'

RSpec.describe History, type: :model do
  it { is_expected.to be_mongoid_document }

  context 'field' do
    %i[take_date return_date].each do |field|
      it { is_expected.to have_field(field).of_type(Time) }
    end
  end

  context 'association' do
    %i[book user].each do |model|
      it { is_expected.to belong_to(model) }
    end
  end

  context 'validation' do
    %i[book user].each do |field|
      it { is_expected.to validate_presence_of(field) }
    end
  end
end
