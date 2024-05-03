# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Application, type: :model do
  context 'validations' do
    it { is_expected.to have_many :application_events }
    it { is_expected.to belong_to :job }
    it { is_expected.to have_db_column :candidate_name }
    it { is_expected.to validate_presence_of :candidate_name }
  end
end
