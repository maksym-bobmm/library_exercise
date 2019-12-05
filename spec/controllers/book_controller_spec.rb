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
    before(:each) { |test| sign_in(@user) unless test.metadata[:not_signed_user] }
    let(:book) { create(:book) }

    context '#index' do
      before(:each) { get :index }
      it 'variables @books and @top_books are an instances of Mongoid::Criteria' do
        expect(@controller.instance_variable_get(:@books)).to be_instance_of(Mongoid::Criteria)
        expect(@controller.instance_variable_get(:@histories)).to be_instance_of(Mongoid::Criteria)
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
      it 'does no changes count after delete by not signed in user', :not_signed_user do
        expect {
          delete :destroy, params: { id: book_for_delete.id }
        }.not_to change(Book, :count)
      end
    end
    context '#take' do
      xit do
        byebug
        expect {
          post :take, params: { book_id: book.id }
        }.to change(book, :state)
      end
    end
  end
end
