require 'rails_helper'

RSpec.describe CommentsController, type: :controller do

  describe 'route' do
    it { is_expected.to route(:post, '/comments').to(action: :create) }
    it { is_expected.to route(:patch, '/comments/1').to(action: :update, id: 1) }
    it { is_expected.to route(:put, '/comments/1').to(action: :update, id: 1) }
    it { is_expected.to route(:delete, '/comments/1').to(action: :destroy, id: 1) }
  end
  describe 'action tests check that' do
    before do
      @user = create(:user)
      @book = create(:book)
    end
    let!(:comment) { create(:comment, book_id: @book.id, user_id: @user.id) }
    context 'not signed in user' do
      it 'do not delete comment on DELETE Comment#destoy' do
        expect { delete :destroy, params: { id: comment.id } }.to_not change(Comment, :count)
      end
      it 'do not create comment on POST Comment#create' do
        expect {
          post :create, params: { book_id: @book.id, user_id: @user.id, body: 'test' }
        }.to_not change(Comment, :count)
      end
      it 'do not update comment on PATCH Comment#update' do
        expect {
          patch :update, params: { id: @book.id, comment_id: comment.id, body: 'test' }
          comment.reload
        }.to_not change { comment.body }
      end
      it 'do not update comment on PUT Comment#update' do
        expect {
          put :update, params: { id: @book.id, comment_id: comment.id, body: 'test' }
          comment.reload
        }.to_not change { comment.body }
      end
    end
    context 'signed in user' do
      before(:each) { sign_in @user }
      it 'delete comment on DELETE Comment#destoy' do
        expect { delete :destroy, params: { id: comment.id } }.to change(Comment, :count)
      end
      it 'create comment on POST Comment#create' do
        expect {
          post :create, params: { book_id: @book.id, user_id: @user.id, body: 'test' }
        }.to change(Comment, :count)
      end
      it 'update comment on PATCH Comment#update' do
        expect {
          patch :update, params: { id: @book.id, comment_id: comment.id, body: 'test' }
          comment.reload
        }.to change { comment.body }
      end
      it 'update comment on PUT Comment#update' do
        expect {
          put :update, params: { id: @book.id, comment_id: comment.id, body: 'test' }
          comment.reload
        }.to change { comment.body }
      end
    end
  end
  describe 'html response code' do
    before do
      @user = create(:user)
      @book = create(:book)
    end
    let!(:comment) { create(:comment, book_id: @book.id, user_id: @user.id) }

    context 'signed in user', :js => true do
      before(:each) { sign_in @user }
      it 'gets 200 on POST comment#create' do
        post :create, params: { book_id: @book.id, user_id: @user.id, body: 'test' }
        is_expected.to respond_with(200)
      end
      it 'gets 200 on PATCH comment#update' do
        patch :update, params: { id: @book.id, comment_id: comment.id, body: 'test' }
        is_expected.to respond_with(200)
      end
      it 'gets 200 on PUT comment#update' do
        put :update, params: { id: @book.id, comment_id: comment.id, body: 'test' }
        is_expected.to respond_with(200)
      end
      it 'gets 200 on DELETE comment#destroy' do
      delete :destroy, params: { id: comment.id }
        is_expected.to respond_with(200)
      end
    end
  end
  #describe "GET #new" do
  #  it "returns http success" do
  #    get :new
  #    expect(response).to have_http_status(:missing)
  #  end
  #end
end
