# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GetActivatedApplicationsService, type: :service do
  let!(:job) { create(:job) }
  let!(:application) { create(:application, job:) }
  let(:expected_data) { [] }

  subject { described_class.call }

  it 'should be empty' do
    expect(applications_to_hashes(subject)).to eq expected_data
  end

  context 'when job activated' do
    let!(:activated_event) { create(:job_event_activated, job:) }
    let(:application_data) do
      {
        application_status: 'applied',
        candidate_name: application.candidate_name,
        job_title: job.title,
        last_interview_date: nil,
        notes_count: 0
      }
    end
    let(:expected_data) { [application_data] }

    it 'should contain application data' do
      expect(applications_to_hashes(subject)).to eq expected_data
    end

    context 'when contains note' do
      let!(:note_event) { create(:application_event_note, application:) }
      let(:application_data) { super().merge(notes_count: 1) }

      it 'increase notes_count and does not change status' do
        expect(applications_to_hashes(subject)).to eq expected_data
      end
    end

    context 'when interview event present' do
      let(:interview_date) { 1.week.ago.to_date }
      let!(:interview_event) do
        create(:application_event_interview, application:, properties: { interview_date: })
      end
      let(:application_data) { super().merge(application_status: 'interview', last_interview_date: interview_date) }

      it 'changes status and interview date' do
        expect(applications_to_hashes(subject)).to eq expected_data
      end

      context 'when present more then one interview' do
        let(:additional_interview_date) { 1.day.since.to_date }
        let!(:additional_interview_event) do
          create(:application_event_interview, application:, properties: { interview_date: additional_interview_date })
        end
        let(:application_data) { super().merge(last_interview_date: additional_interview_date) }

        it 'shows last interview date by date' do
          expect(applications_to_hashes(subject)).to eq expected_data
        end
      end

      context 'when additional interview present, but before previous interview' do
        let(:additional_interview_date) { 2.weeks.ago.to_date }
        let!(:additional_interview_event) do
          create(:application_event_interview, application:, properties: { interview_date: additional_interview_date })
        end

        it 'shows last interview date by date' do
          expect(applications_to_hashes(subject)).to eq expected_data
        end
      end
    end

    context 'when hired event present' do
      let!(:hired_event) { create(:application_event_hired, application:) }
      let(:application_data) { super().merge(application_status: 'hired') }

      it 'shows hired status' do
        expect(applications_to_hashes(subject)).to eq expected_data
      end
    end

    context 'when rejected event present' do
      let!(:rejected_event) { create(:application_event_rejected, application:) }
      let(:application_data) { super().merge(application_status: 'rejected') }

      it 'shows rejected status' do
        expect(applications_to_hashes(subject)).to eq expected_data
      end
    end

    context 'when few different events present' do
      let(:interview_date) { 1.week.ago.to_date }
      let!(:interview_event) do
        create(:application_event_interview, application:, properties: { interview_date: })
      end
      let!(:rejected_event) { create(:application_event_rejected, application:) }
      let(:application_data) do
        super().merge(application_status: 'rejected', last_interview_date: interview_date, notes_count: 1)
      end
      let!(:note_event) { create(:application_event_note, application:) }

      it 'shows rejected status' do
        expect(applications_to_hashes(subject)).to eq expected_data
      end

      context 'additional hired event' do
        let!(:hired_event) { create(:application_event_hired, application:) }
        let(:application_data) { super().merge(application_status: 'hired') }

        it 'shows hired status' do
          expect(applications_to_hashes(subject)).to eq expected_data
        end
      end
    end
  end
end
