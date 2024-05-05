# frozen_string_literal: true

FactoryBot.define do
  factory :application_event_hired, class: Application::Event::Hired do
    application
    properties { { hire_date: 1.week.ago.to_date } }
  end
end
