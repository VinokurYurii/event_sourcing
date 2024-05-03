# frozen_string_literal: true

class Job::Event < ActiveRecord::Base
  belongs_to :job
end
