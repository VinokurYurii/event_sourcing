# frozen_string_literal: true

FactoryBot.define do
  factory :job do
    title { Faker::Job.title }
  end
end
