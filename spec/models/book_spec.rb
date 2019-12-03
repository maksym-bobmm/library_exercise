require 'rails_helper'

RSpec.describe Book, type: :model do
  it { is_expected.to be_mongoid_document }

  describe 'fields' do
    %i[name description author avatar].each do |field|
      it { is_expected.to have_field(field).of_type(String) }
    end
    it { is_expected.to have_field(:state).of_type(Mongoid::Boolean).with_default_value_of(true) }
    it { is_expected.to have_field(:taken_count).of_type(Integer).with_default_value_of(0) }
  end

  describe 'validation' do
    %i[name description author state].each do |field|
      it { is_expected.to validate_presence_of(field) }
    end
    it { is_expected.to validate_numericality_of(:taken_count).greater_than_or_equal_to(0) }
  end

  describe 'association' do
    subject! { create(:book) }
    it { is_expected.to have_many(:comments) }
    it { is_expected.to have_many(:histories).with_dependent(:destroy) }
    it { is_expected.to embed_many(:users_likes) }
  end

  describe 'method' do
    subject { create :book }
    let(:user) { create :user }

    context do
      before do
        (1..5).each do |number|
          subject.users_likes.create(user_id: user.id.to_s, score: number)
        end
      end
      it '\'likes_sum\' returns correct sum' do
        expect(subject.likes_sum).to be 15
      end
      it '\'rating\' returns correct rating' do
        expect(subject.rating).to be 3
      end
    end
    it '\'rating\' returns 0 if there are no likes' do
      expect(subject.rating).to be 0
    end
  end
end
