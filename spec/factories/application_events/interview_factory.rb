# frozen_string_literal: true

FactoryBot.define do
  factory :application_event_interview, class: Application::Event::Interview do
    application
    properties { { interview_date: 10.days.ago.to_date } }
  end
end
