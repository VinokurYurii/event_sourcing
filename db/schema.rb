# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_05_03_135820) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "application_events", force: :cascade do |t|
    t.bigint "application_id"
    t.string "type", null: false
    t.json "properties"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["application_id"], name: "index_application_events_on_application_id"
  end

  create_table "applications", force: :cascade do |t|
    t.bigint "job_id"
    t.string "candidate_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["job_id"], name: "index_applications_on_job_id"
  end

  create_table "job_events", force: :cascade do |t|
    t.bigint "job_id"
    t.string "type", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["job_id"], name: "index_job_events_on_job_id"
  end

  create_table "jobs", force: :cascade do |t|
    t.string "title", null: false
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["title"], name: "index_jobs_on_title", unique: true
  end

end
