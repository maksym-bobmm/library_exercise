require 'rails_helper'

RSpec.describe BookController, type: :controller do
  describe 'route' do
    it { is_expected.to route(:get,   '/book').to(action: :index) }
    it { is_expected.to route(:post,  '/book').to(action: :create) }
    it { is_expected.to route(:get,   '/book/new').to(action: :new) }
    it { is_expected.to route(:get,   '/book/1/edit').to(action: :edit, id: 1) }
    it { is_expected.to route(:get,   '/book/1').to(action: :show, id: 1) }
    it { is_expected.to route(:patch, '/book/1').to(action: :update, id: 1) }
    it { is_expected.to route(:put,   '/book/1').to(action: :update, id: 1) }
    it { is_expected.to route(:delete,'/book/1').to(action: :destroy, id: 1) }
    it { is_expected.to route(:post,  '/book/destroy_multiple').to(action: :destroy_multiple) }
    it { is_expected.to route(:post,  '/book/take').to(action: :take) }
    it { is_expected.to route(:post,  '/book/return').to(action: :return) }
  end
  describe 'action' do
    before(:all) { @user = create(:user) }
    before(:each) { |test| sign_in(@user) unless test.metadata[:not_signed_in_user] }
    let(:book) { create(:book) }

    context '#index' do
      before(:each) { get :index }
      it 'variables @books and @top_books are an instances of Mongoid::Criteria' do
        expect(@controller.instance_variable_get(:@books)).to be_instance_of(Mongoid::Criteria)
      end
      it 'variable @top_books is an instance of Array' do
        expect(@controller.instance_variable_get(:@top_books)).to be_instance_of(Array)
      end
      it 'is expected to render template index' do
        expect(response).to render_template(:index)
      end
    end
    context '#create' do
      it 'changes count after create by signed in user' do
        expect {
          post :create, params: { name: 'test', description: 'test', author: 'test'}
        }.to change(Book, :count).by(1)
      end
      it 'does not change count after create by not signed in user' do
        expect {
          post :create, params: { name: 'test', description: 'test', author: 'test'}
        }.to change(Book, :count)
      end
    end
    context '#new' do
      subject { get :new }
      it { is_expected.to render_template(:new) }
    end
    context '#edit' do
      it do
        expect(get: '/edit').not_to be_routable
      end
    end
    context '#update' do
      it 'is expected not to be routable with PATCH' do
        expect(patch: '/' + book.id.to_s, params: { id: book.id }).not_to be_routable
      end
      it 'is expected not to be routable with PUT' do
        expect(put: '/' + book.id.to_s, params: { id: book.id }).not_to be_routable
      end
    end
    context '#show' do
      before(:each) { get :show, params: { id: book.id } }
      it do
        expect(request).to render_template(:show)
      end
      it 'variables @book, @rating_score and @likes_count are expected not to be nil' do
        expect(@controller.instance_variable_get(:@book)).not_to be_nil
        expect(@controller.instance_variable_get(:@rating_score)).not_to be_nil
        expect(@controller.instance_variable_get(:@likes_count)).not_to be_nil
      end
      it 'variables @rating_score and @likes_count are expected to be an instance of Book' do
        expect(@controller.instance_variable_get(:@rating_score)).to be_instance_of(Integer)
        expect(@controller.instance_variable_get(:@likes_count)).to be_instance_of(Integer)
      end
      it 'variable @book is expected to be an instance of Book' do
        expect(@controller.instance_variable_get(:@book)).to be_instance_of(Book)
      end
      it 'variable @parent_comments is expected to be an instance of Mongoid::Criteria' do
        expect(@controller.instance_variable_get(:@parent_comments)).to be_instance_of(Mongoid::Criteria)
      end
    end
    context '#destroy' do
      let!(:book_for_delete) { create(:book) }
      it 'changes count after delete by signed in user' do
        expect {
          delete :destroy, params: { id: book_for_delete.id }
        }.to change(Book, :count).by(-1)
      end
      it 'does no changes count after delete by not signed in user', :not_signed_in_user do
        expect {
          delete :destroy, params: { id: book_for_delete.id }
        }.not_to change(Book, :count)
      end
    end
    context '#take' do
      it 'is expected to change `Book#state` by signed in user' do
        expect{
          post :take, params: { book_id: book.id }
          book.reload
        }.to change(book, :state)
      end
      it 'is expected to change `History.count` by 1 with signed in user' do
        expect{
          post :take, params: { book_id: book.id }
        }.to change(History, :count).by(1)
      end
      it 'is expected not to change `Book#state` by not signed in user', :not_signed_in_user do
        expect{
          post :take, params: { book_id: book.id }
          book.reload
        }.to_not change(book, :state)
      end
      it 'is expected not to change `History.count` with not signed in user', :not_signed_in_user do
        expect{
          post :take, params: { book_id: book.id }
        }.to_not change(History, :count)
      end
      it 'is expected not to change `Book#state` if book`s state is already false', :not_signed_in_user do
        expect{
          book.state = false
          post :take, params: { book_id: book.id }
          book.reload
        }.to_not change(book, :state)
      end
      it 'is expected not to change `History.count` if book`s state is already false', :not_signed_in_user do
        expect{
          book.state = false
          post :take, params: { book_id: book.id }
        }.to_not change(History, :count)
      end
    end
    context '#return' do
      let(:history) { create(:history_take_only, user_id: @user.id, book_id: book.id) }
      before(:each) { book.update_attributes(state: false) }
      it 'is expected to change `Book#state` by signed in user' do
        expect{
          post :return, params: { book_id: book.id }
          book.reload
        }.to change(book, :state)
      end
      it 'is expected to change return_date in last history record by signed in user' do
        history
        expect{
          post :return, params: { book_id: book.id }
        }.to change { book.histories.last.return_date }
      end
      it 'is expected not to change `Book#state` by not signed in user', :not_signed_in_user do
        expect{
          post :return, params: { book_id: book.id }
          book.reload
        }.to_not change(book, :state)
      end
      it 'is expected not to change `History.count` with not signed in user', :not_signed_in_user do
        expect{
          post :return, params: { book_id: book.id }
        }.to_not change(History, :count)
      end
      it 'is expected not to change `Book#state` if book`s state is already true', :not_signed_in_user do
        expect{
          book.state = false
          post :return, params: { book_id: book.id }
          book.reload
        }.to_not change(book, :state)
      end
      it 'is expected not to change `History.count` if book`s state is already true', :not_signed_in_user do
        expect{
          book.state = false
          post :return, params: { book_id: book.id }
        }.to_not change(History, :count)
      end
    end
    context '#destroy_multiple' do
      before(:each) do |example|
        unless example.metadata[:no_ids]
          3.times { create(:book) }
          @ids = Array.new(1){ Book.first.id.to_s}
          @ids << Book.last.id.to_s
        end
      end
      it 'is expected to change `Book.count` by -2 by signed in user' do
        expect{
          post :destroy_multiple, params: { books_ids: @ids }
        }.to change(Book, :count).by(-2)
      end
      it 'is expected not to change `Book.count` by signed in user', :not_signed_in_user do
        expect{
          post :destroy_multiple, params: { books_ids: @ids }
        }.to_not change(Book, :count)
      end
      it 'is expected not to change `Book.count` without books_ids in params', :no_ids do
        expect{
          post :destroy_multiple
        }.to_not change(Book, :count)
      end
    end
  end
end
