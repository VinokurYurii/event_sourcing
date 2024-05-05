# frozen_string_literal: true

class GetJobStatisticsService
  ACTIVATED_EVENT = 'Job::Event::Activated'
  INTERVIEW_EVENT = 'Application::Event::Interview'
  HIRED_EVENT = 'Application::Event::Hired'
  REJECTED_EVENT = 'Application::Event::Rejected'
  NOTE_EVENT = 'Application::Event::Note'

  class << self
    def call
      Job
        .select(select_sql)
        .joins(job_status_sql)
        .joins(application_statuses_sql)
        .group('jobs.id, jobs.title, j_numbered_events.type')
    end

    private

    def select_sql
      <<-SQL
        jobs.id,
        jobs.title,
        COUNT(CASE WHEN a.type = '#{HIRED_EVENT}' THEN 1 END) hired,
        COUNT(CASE WHEN a.type = '#{REJECTED_EVENT}' THEN 1 END) rejected,
        COUNT(CASE WHEN (a.type IS NULL AND a.job_id IS NOT NULL)
                        OR (a.type != '#{HIRED_EVENT}' AND a.type != '#{REJECTED_EVENT}') THEN 1
              END) ongoing,
        CASE
          WHEN j_numbered_events.type = '#{ACTIVATED_EVENT}' THEN 'activated'
          ELSE 'deactivated'
        END status
      SQL
    end

    def job_status_sql
      <<-SQL
        LEFT JOIN (
          SELECT job_id, type, ROW_NUMBER() OVER (PARTITION BY job_id ORDER BY id DESC) AS rn
          FROM job_events
        ) AS j_numbered_events
          ON jobs.id = j_numbered_events.job_id
            AND j_numbered_events.rn = 1
      SQL
    end

    def application_statuses_sql
      <<-SQL
        LEFT JOIN (
          SELECT job_id, type
          FROM applications
              LEFT JOIN (
                SELECT *, ROW_NUMBER() OVER (PARTITION BY application_id ORDER BY id DESC) AS rn
                FROM application_events ae_window
                WHERE ae_window.type != '#{NOTE_EVENT}'
              ) AS a_numbered_events
                ON applications.id = a_numbered_events.application_id
                  AND a_numbered_events.rn = 1
        ) a
          ON jobs.id = a.job_id
      SQL
    end
  end
end
