require 'rails_helper'

RSpec.describe RatingController, type: :controller do
  context '#create' do
    let(:user) { create(:user) }
    let(:book) { create(:book) }
    subject do
      post :create, params: { book_id: book.id, score: (1..5).to_a.sample }
      book.reload
    end
    before(:each) do |example|
      sign_in user unless example.metadata[:not_signed_in]
    end

    it 'is expected to change `book.rating` by signed in user' do
      expect { subject }.to change { book.rating }
    end
    it 'is expected not to change `book.rating` by not signed in user', :not_signed_in do
      expect { subject }.to_not change { book.rating }
    end
  end
end
