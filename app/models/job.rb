# frozen_string_literal: true

class Job < ActiveRecord::Base
  has_many :job_events, class_name: 'Job::Event'
  has_many :applications

  def activated?
    return false unless job_events.present?

    job_events.last.type == 'Job::Event::Activated'
  end

  def deactivated?
    return true unless job_events.present?

    job_events.last.type == 'Job::Event::Deactivated'
  end
end
