# frozen_string_literal: true

job1 = Job.create(title: 'first job')
Job::Event::Activated.create(job: job1)
Job::Event::Deactivated.create(job: job1)
Job::Event::Activated.create(job: job1)

job2 = Job.create(title: 'second job')
Job::Event::Activated.create(job: job2)
Job::Event::Deactivated.create(job: job2)

job3 = Job.create(title: 'third job')
Job::Event::Activated.create(job: job3)

Job.create(title: 'fourth job')

application1_1 = Application.create(candidate_name: 'name1_1', job: job1)
Application::Event::Note.create(application: application1_1, properties: { content: 'content for 1_1 1' })
Application::Event::Interview.create(application: application1_1, properties: { interview_date: 2.weeks.ago.to_date })
Application::Event::Interview.create(application: application1_1, properties: { interview_date: 1.week.ago.to_date })
Application::Event::Hired.create(application: application1_1, properties: { hire_date: 1.week.ago.to_date })

application1_2 = Application.create(candidate_name: 'name1_2', job: job1)
Application::Event::Note.create(application: application1_2, properties: { content: 'content for 1_2 1' })
Application::Event::Interview.create(application: application1_2, properties: { interview_date: 16.days.ago.to_date })
Application::Event::Rejected.create(application: application1_2)
Application::Event::Note.create(application: application1_2, properties: { content: 'content for 1_2 2' })

Application.create(candidate_name: 'name1_3', job: job1)

application2_1 = Application.create(candidate_name: 'name2_1', job: job2)
Application::Event::Note.create(application: application2_1, properties: { content: 'content for 2_1 1' })
Application::Event::Interview.create(application: application2_1, properties: { interview_date: 2.weeks.ago.to_date })
Application::Event::Hired.create(application: application2_1, properties: { hire_date: 1.week.ago.to_date })

application3_1 = Application.create(candidate_name: 'name3_1', job: job3)
Application::Event::Note.create(application: application3_1, properties: { content: 'content for 3_1 1' })
Application::Event::Interview.create(application: application3_1, properties: { interview_date: 3.weeks.ago.to_date })
Application::Event::Interview.create(application: application3_1, properties: { interview_date: 2.week.ago.to_date })
Application::Event::Hired.create(application: application3_1, properties: { hire_date: 10.days.ago.to_date })

application3_2 = Application.create(candidate_name: 'name3_2', job: job3)
Application::Event::Note.create(application: application3_2, properties: { content: 'content for 3_2 1' })
Application::Event::Interview.create(application: application3_2, properties: { interview_date: 13.days.ago.to_date })
Application::Event::Rejected.create(application: application3_2)
Application::Event::Note.create(application: application3_2, properties: { content: 'content for 3_2 2' })
