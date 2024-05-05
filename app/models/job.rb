# frozen_string_literal: true

class Job < ActiveRecord::Base
  ACTIVATED_EVENT = 'Job::Event::Activated'

  has_many :job_events, class_name: 'Job::Event'
  has_many :applications

  validates :title, presence: true, uniqueness: true

  scope :active, -> { joins(self.activated_job_sql) }

  def active?
    return false unless job_events.present?

    job_events.last.type == ACTIVATED_EVENT
  end

  def self.activated_job_sql
    <<-SQL
      JOIN (
        SELECT job_id, type, ROW_NUMBER() OVER (PARTITION BY job_id ORDER BY id DESC) AS rn
        FROM job_events
      ) AS numbered_events
      ON jobs.id = numbered_events.job_id
        AND numbered_events.rn = 1
        AND numbered_events.type = '#{ACTIVATED_EVENT}'
    SQL
  end
end
