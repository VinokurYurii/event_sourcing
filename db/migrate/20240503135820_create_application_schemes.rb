# frozen_string_literal: true

class CreateApplicationSchemes < ActiveRecord::Migration[7.1]
  def change
    create_table :applications do |t|
      t.belongs_to :job

      t.string :candidate_name

      t.timestamps
    end

    create_table :application_events do |t|
      t.belongs_to :application

      t.string :type, null: false
      t.json :properties

      t.timestamps
    end
  end
end
