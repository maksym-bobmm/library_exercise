require 'rails_helper'

RSpec.describe RatingController, type: :controller do
  describe 'action' do
    context '#create' do
      let(:user) { create(:user) }
      let(:book) { create(:book) }
      let(:create_with_xhr) { post :create, xhr: true, params: { book_id: book.id, score: (1..5).to_a.sample } }
      before(:each) do |example|
        sign_in user unless example.metadata[:not_signed_in]
      end
      context 'is expected book.rating' do
        subject do
          create_with_xhr
          book.reload
        end
        it 'is expected to change `book.rating` by signed in user' do
          expect { subject }.to change { book.rating }
        end
        it 'is expected not to change `book.rating` by not signed in user', :not_signed_in do
          expect { subject }.to_not change { book.rating }
        end
      end
      it 'is expected to respond with status code success' do
        create_with_xhr
        expect(response).to have_http_status(:success)
      end
      it 'is expected to get ajax with signed in user' do
        create_with_xhr
        expect(response.content_type).to include('application/json')
      end
      it 'is expected not to get ajax with not signed in user', :not_signed_in do
        create_with_xhr
        expect(response.content_type).to be nil
      end

    end
  end
end
