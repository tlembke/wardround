# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150416115433) do

  create_table "claims", force: :cascade do |t|
    t.date     "date"
    t.integer  "hospital_id"
    t.integer  "doctor_id"
    t.integer  "round_id"
    t.integer  "duration"
    t.datetime "start"
    t.datetime "finish"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "claimable"
  end

  create_table "hospitals", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.boolean  "showtime"
    t.integer  "duration"
    t.string   "item",       limit: 255
  end

  create_table "patients", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.integer  "ward_id"
    t.date     "admission"
    t.date     "discharge"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "reason",     limit: 255
    t.text     "note"
    t.string   "mrn",        limit: 255
    t.integer  "status"
    t.integer  "under"
    t.integer  "charge"
  end

  create_table "rounds", force: :cascade do |t|
    t.integer  "doctor_id"
    t.integer  "hospital_id"
    t.date     "date"
    t.integer  "duration"
    t.integer  "claimable"
    t.datetime "start"
    t.datetime "finish"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "number"
  end

  create_table "sessions", force: :cascade do |t|
    t.string   "session_id", limit: 255, null: false
    t.text     "data"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at"

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.string   "confirmation_token",     limit: 255
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email",      limit: 255
    t.integer  "failed_attempts",                    default: 0
    t.string   "unlock_token",           limit: 255
    t.datetime "locked_at"
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "name",                   limit: 255
    t.string   "initials",               limit: 255
    t.string   "role",                   limit: 255
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true

  create_table "visits", force: :cascade do |t|
    t.integer  "patient_id"
    t.integer  "doctor_id"
    t.integer  "ward_id"
    t.date     "date"
    t.integer  "duration"
    t.string   "item",       limit: 255
    t.text     "chargenote"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "round_id"
    t.boolean  "billed"
  end

  create_table "wards", force: :cascade do |t|
    t.integer  "hospital_id"
    t.string   "name",        limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

end
