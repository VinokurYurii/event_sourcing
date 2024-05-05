# frozen_string_literal: true

FactoryBot.define do
  factory :job_event_deactivated, class: Job::Event::Deactivated do
    job
  end
end
