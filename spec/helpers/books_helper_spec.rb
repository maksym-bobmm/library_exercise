require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the BooksHelper. For example:
#
# describe BooksHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
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
    it "is expected to be an instance of ActiveSupport::SafeBuffer" do
      expect(helper.filled_rating_tags(rand(1..5), book)).to be_instance_of(ActiveSupport::SafeBuffer)
    end
    it "is expected not to be nil" do
      expect(helper.filled_rating_tags(rand(1..5), book)).to_not be nil
    end
  end
  describe '#empty_rating_tags' do
    it "is expected to return an instance of ActiveSupport::SafeBuffer" do
      expect(helper.empty_rating_tags(rand(1..5), book)).to be_instance_of(ActiveSupport::SafeBuffer)
    end
    it "is expected not to return nil" do
      expect(helper.empty_rating_tags(rand(1..5), book)).to_not be nil
    end
  end
  describe '#draw_rating' do
    it "is expected to return an instance of ActiveSupport::SafeBuffer" do
      expect(helper.draw_rating(rand(1..5), book)).to be_instance_of(ActiveSupport::SafeBuffer)
    end
    it "is expected not to return nil" do
      expect(helper.draw_rating(rand(1..5), book)).to_not be nil
    end
  end
  describe '#draw_take_button' do
    before(:each) { sign_in user }
    it "is expected to return an instance of ActiveSupport::SafeBuffer" do
      #allow(helper).to receive(:current_user).and_return(user)
      expect(helper.draw_take_button(book)).to be_instance_of(ActiveSupport::SafeBuffer)
    end
    it "is expected not to return nil" do
      expect(helper.draw_take_button(book)).to_not be nil
    end
  end
end
