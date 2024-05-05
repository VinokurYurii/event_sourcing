# frozen_string_literal: true

require 'rails_helper'

RSpec.describe JobsController, type: :controller do
  describe 'GET #activated' do
    # before(:all) do
    # end
    #
    # after(:all) { cleanup_database }

    subject { get :activated }

    it 'returns owned records' do
      subject
      expect(response).to have_http_status(:ok)
      expect(json_response).to eq({ 'a' => 'b' })
    end
  end
end
