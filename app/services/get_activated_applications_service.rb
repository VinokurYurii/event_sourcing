# frozen_string_literal: true

class GetActivatedApplicationsService
  ACTIVATED_EVENT = 'Job::Event::Activated'
  INTERVIEW_EVENT = 'Application::Event::Interview'
  HIRED_EVENT = 'Application::Event::Hired'
  REJECTED_EVENT = 'Application::Event::Rejected'
  NOTE_EVENT = 'Application::Event::Note'

  class << self
    def call
      Application
        .select(select_sql)
        .joins(join_last_event_sql)
        .joins(join_notes_sql)
        .joins(join_interviews_sql)
        .joins(:job)
        .where(jobs: { id: activated_job_ids })
        .group('applications.id, job_title, numbered_events.type')
    end

    private

    def select_sql
      <<-SQL
        applications.candidate_name,
        jobs.title job_title,
        CASE
          WHEN numbered_events.type = '#{INTERVIEW_EVENT}' THEN 'interview'
          WHEN numbered_events.type = '#{HIRED_EVENT}' THEN 'hired'
          WHEN numbered_events.type = '#{REJECTED_EVENT}' THEN 'rejected'
          ELSE 'applied'
        END application_status,
        COUNT(a_notes.id) notes_count,
        MAX((a_interviews.properties->>'interview_date')::date) last_interview_date
      SQL
    end

    def join_last_event_sql
      <<-SQL
        LEFT JOIN (
            SELECT *, ROW_NUMBER() OVER (PARTITION BY application_id ORDER BY created_at DESC) AS rn
            FROM application_events ae_window
            WHERE ae_window.type != '#{NOTE_EVENT}'
        ) AS numbered_events
            ON applications.id = numbered_events.application_id
              AND numbered_events.rn = 1
      SQL
    end

    def join_notes_sql
      <<-SQL
        LEFT JOIN application_events a_notes
          ON applications.id = a_notes.application_id
            AND a_notes.type = '#{NOTE_EVENT}'
      SQL
    end

    def join_interviews_sql
      <<-SQL
        LEFT JOIN application_events a_interviews
          ON applications.id = a_interviews.application_id
            AND a_interviews.type = '#{INTERVIEW_EVENT}'
      SQL
    end

    def activated_job_sql
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

    def activated_job_ids
      Job.joins(activated_job_sql).pluck(:id)
    end
  end
end
