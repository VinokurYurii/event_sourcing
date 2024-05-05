# frozen_string_literal: true

FactoryBot.define do
  factory :application do
    job
    candidate_name { Faker::Name.name }
  end
end
