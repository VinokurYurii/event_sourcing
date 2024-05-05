# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationsController, type: :controller do
  describe 'GET #activated' do
    let!(:job) { create(:job) }
    let!(:application) { create(:application, job:) }
    let!(:activated_event) { create(:job_event_activated, job:) }
    let(:expected_response) do
      [
        {
          application_status: 'applied',
          candidate_name: application.candidate_name,
          job_title: job.title,
          last_interview_date: nil,
          notes_count: 0
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
      expect(GetActivatedApplicationsService).to receive(:call).and_call_original
      subject
    end
  end
end
