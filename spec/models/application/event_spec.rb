# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Application::Event, type: :model do
  context 'validations' do
    it { is_expected.to belong_to :application }
    it { is_expected.to have_db_column :properties }
  end
end
