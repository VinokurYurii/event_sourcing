# frozen_string_literal: true

class Application < ActiveRecord::Base
  belongs_to :job
  has_many :application_events, class_name: 'Application::Event'

  validates :candidate_name, presence: true
end
