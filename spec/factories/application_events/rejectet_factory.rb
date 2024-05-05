# frozen_string_literal: true

FactoryBot.define do
  factory :application_event_rejected, class: Application::Event::Rejected do
    application
  end
end
