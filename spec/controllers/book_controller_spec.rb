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
end
