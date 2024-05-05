# frozen_string_literal: true

class ApplicationSerializer < ActiveModel::Serializer
  attributes :candidate_name, :job_title, :application_status, :notes_count, :last_interview_date
end
