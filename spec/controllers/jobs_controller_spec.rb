# frozen_string_literal: true

require 'rails_helper'

RSpec.describe JobsController, type: :controller do
  describe 'GET #activated' do
    let!(:job) { create(:job) }
    let(:expected_response) do
      [
        {
          title: job.title,
          status: 'deactivated',
          hired: 0,
          rejected: 0,
          ongoing: 0
        }
      ]
    end

    subject { get :index }

    it 'returns proper data' do
      subject
      expect(response).to have_http_status(:ok)
      expect(json_response).to eq(expected_response)
    end

    it 'calls GetActiveJobApplicationsService' do
      expect(GetJobStatisticsService).to receive(:call).and_call_original
      subject
    end
  end
end
