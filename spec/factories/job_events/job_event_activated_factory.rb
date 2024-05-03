# frozen_string_literal: true

FactoryBot.define do
  factory :job_event_activated, class: Job::Event::Activated do
    job
  end
end
