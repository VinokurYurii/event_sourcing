# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Job, type: :model do
  context 'validations' do
    subject { create :job }

    it { is_expected.to have_db_column :title }
    it { is_expected.to validate_presence_of :title }
    it { is_expected.to validate_uniqueness_of :title }
    it { is_expected.to have_many :job_events }
    it { is_expected.to have_many :applications }
  end

  describe ':active?' do
    let!(:job) { create(:job) }

    subject { job.active? }

    it 'should be deactivated' do
      expect(subject).to be_falsey
    end

    context 'when activated event present' do
      before do
        create(:job_event_activated, job:)
      end

      it 'should be activated' do
        expect(subject).to be_truthy
      end

      context 'when last event deactivated' do
        before do
          create(:job_event_deactivated, job:)
        end

        it 'should be deactivated' do
          expect(subject).to be_falsey
        end
      end
    end
  end
end
