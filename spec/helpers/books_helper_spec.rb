# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BooksHelper, type: :helper do
  let(:book) { create(:book) }
  let(:user) { create(:user) }
  describe '#receive_book_state' do
    it 'is expected to be \'In\' for book#state == true' do
      expect(helper.receive_book_state(book)).to be == 'In'
    end
    it 'is expected to be \'Out\' for book#state == false' do
      book.state = false
      expect(helper.receive_book_state(book)).to be == 'Out'
    end
  end
  describe '#filled_rating_tags' do
    it 'is expected to be an instance of ActiveSupport::SafeBuffer' do
      expect(helper.filled_rating_tags(rand(1..5), book)).to be_instance_of(ActiveSupport::SafeBuffer)
    end
    it 'is expected not to be nil' do
      expect(helper.filled_rating_tags(rand(1..5), book)).to_not be nil
    end
  end
  describe '#empty_rating_tags' do
    it 'is expected to return an instance of ActiveSupport::SafeBuffer' do
      expect(helper.empty_rating_tags(rand(1..5), book)).to be_instance_of(ActiveSupport::SafeBuffer)
    end
    it 'is expected not to return nil' do
      expect(helper.empty_rating_tags(rand(1..5), book)).to_not be nil
    end
  end
  describe '#draw_rating' do
    it 'is expected to return an instance of ActiveSupport::SafeBuffer' do
      expect(helper.draw_rating(rand(1..5), book)).to be_instance_of(ActiveSupport::SafeBuffer)
    end
    it 'is expected not to return nil' do
      expect(helper.draw_rating(rand(1..5), book)).to_not be nil
    end
  end
  describe '#draw_take_button' do
    before(:each) { sign_in user }
    it 'is expected to return an instance of ActiveSupport::SafeBuffer' do
      expect(helper.draw_take_button(book)).to be_instance_of(ActiveSupport::SafeBuffer)
    end
    it 'is expected not to return nil' do
      expect(helper.draw_take_button(book)).to_not be nil
    end
  end
  describe '#receive_book_taker' do
    before(:each) do |example|
      sign_in user
      create(:history_take_only, user_id: user.id, book_id: book.id) unless example.metadata[:no_history]
    end
    it 'is expected to return user\'s email' do
      expect(receive_book_taker(book)).to eq user.email.to_s
    end
    it 'is expected to return a String' do
      expect(receive_book_taker(book)).to be_instance_of(String)
    end
    it 'is expected to return nothing when book does not have history', :no_history do
      expect(receive_book_taker(book)).to be_nil
    end
  end
end
