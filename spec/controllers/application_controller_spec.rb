# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DeviseController, type: :controller do
  context '' do
    it { is_expected.to use_before_action(:configure_permitted_parameters) }
  end
end
