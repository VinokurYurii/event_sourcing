# frozen_string_literal: true

module ControllerHelpers
  def applications_to_hashes(applications)
    applications.map do |application|
      {
        candidate_name: application.candidate_name,
        job_title: application.job_title,
        application_status: application.application_status,
        notes_count: application.notes_count,
        last_interview_date: application.last_interview_date
      }
    end
  end
end

RSpec.configure do |config|
  config.include ControllerHelpers, type: :service
end
