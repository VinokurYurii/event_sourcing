# frozen_string_literal: true

class CreateJobsSchemes < ActiveRecord::Migration[7.1]
  def change
    create_table :jobs do |t|
      t.string :title, null: false
      t.string :description

      t.timestamps
    end

    create_table :job_events do |t|
      t.belongs_to :job
      t.string :type, null: false

      t.timestamps
    end

    add_index :jobs, :title, unique: true
  end
end
