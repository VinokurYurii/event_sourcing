# frozen_string_literal: true

FactoryBot.define do
  factory :application_event_note, class: Application::Event::Note do
    application
    properties { { content: Faker::Lorem.sentence(word_count: 5) } }
  end
end
