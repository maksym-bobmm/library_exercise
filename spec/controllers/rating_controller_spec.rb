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
      subject do
        create_with_xhr
        book.reload
      end
      context 'is expected book.rating' do
        it 'changes `book.rating` with signed in user' do
          expect { subject }.to change { book.rating }
        end
        it 'changes `book.rating` with not signed in user', :not_signed_in do
          expect { subject }.to_not change { book.rating }
        end
      end
      context 'returns status' do
        it 'success (2xx)' do
          create_with_xhr
          expect(response).to have_http_status(:success)
        end
      end
      context 'response' do
        it 'is expected not to get ajax with not signed in user', :not_signed_in do
          create_with_xhr
          expect(response.content_type).to be nil
        end
        it 'contain `tags:` and `average_rating:` in json with signed in user' do
          create_with_xhr
          expect(response.content_type).to include('application/json')
          expect(response.body).to include('"tags":')
          expect(response.body).to include('"average_rating":')
        end
        it 'contain `"liked":false` in json with user that not liked book' do
          create_with_xhr
          expect(response.content_type).to include('application/json')
          expect(response.body).to include('"already_liked":false')
        end
        xit 'contain `"liked":true` in json with user that liked book' do
          create_with_xhr
          create_with_xhr
          expect(response.content_type).to include('application/json')
          expect(response.body).to include('"already_liked":true')
        end
      end
    end
  end
end
