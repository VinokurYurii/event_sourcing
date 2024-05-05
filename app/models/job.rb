# frozen_string_literal: true

class Job < ActiveRecord::Base
  ACTIVATED_EVENT = 'Job::Event::Activated'

  has_many :job_events, class_name: 'Job::Event'
  has_many :applications

  validates :title, presence: true, uniqueness: true

  def active?
    return false unless job_events.present?

    job_events.last.type == ACTIVATED_EVENT
  end
end
