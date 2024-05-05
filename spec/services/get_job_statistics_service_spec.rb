# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GetJobStatisticsService, type: :service do
  let!(:job) { create(:job) }
  let(:job_data) do
    {
      title: job.title,
      status: 'deactivated',
      hired: 0,
      rejected: 0,
      ongoing: 0
    }
  end
  let(:expected_data) { [job_data] }

  subject { described_class.call }

  it 'should contain job statistics' do
    expect(jobs_to_hashes(subject)).to eq expected_data
  end

  context 'when ongoing applications present' do
    let!(:application1) { create(:application, job:) }
    let!(:note_event) { create(:application_event_note, application: application1) }
    let!(:application2) { create(:application, job:) }
    let!(:interview_event) { create(:application_event_interview, application: application2) }
    let!(:application3) { create(:application, job:) }
    let(:job_data) { super().merge(ongoing: 3) }

    it 'should contain ongoing data' do
      expect(jobs_to_hashes(subject)).to eq expected_data
    end
  end

  context 'when hired applications present' do
    let!(:application1) { create(:application, job:) }
    let!(:hired_event1) { create(:application_event_hired, application: application1) }
    let!(:note_event) { create(:application_event_note, application: application1) }
    let!(:application2) { create(:application, job:) }
    let!(:hired_event2) { create(:application_event_hired, application: application2) }
    let(:job_data) { super().merge(hired: 2) }

    it 'should contain hired data' do
      expect(jobs_to_hashes(subject)).to eq expected_data
    end
  end

  context 'when rejected applications present' do
    let!(:application) { create(:application, job:) }
    let!(:rejected_event) { create(:application_event_rejected, application:) }
    let(:job_data) { super().merge(rejected: 1) }

    it 'should contain hired data' do
      expect(jobs_to_hashes(subject)).to eq expected_data
    end
  end

  context 'when status events present' do
    let!(:activated_event1) { create(:job_event_activated, job:) }
    let(:job_data) { super().merge(status: 'activated') }

    it 'should be activated status' do
      expect(jobs_to_hashes(subject)).to eq expected_data
    end

    context 'when deactivated' do
      let!(:activated_event2) { create(:job_event_deactivated, job:) }
      let(:job_data) { super().merge(status: 'deactivated') }

      it 'should be deactivated status' do
        expect(jobs_to_hashes(subject)).to eq expected_data
      end
    end
  end
end
