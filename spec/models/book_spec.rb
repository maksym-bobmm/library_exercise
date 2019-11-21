require 'rails_helper'

RSpec.describe Book, type: :model do
  context 'validation' do
    %i[name description author state].each do |field|
      it { is_expected.to validate_presence_of(field)  }
    end
  end
end
