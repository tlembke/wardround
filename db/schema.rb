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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130424134345) do

  create_table "claims", :force => true do |t|
    t.date     "date"
    t.integer  "hospital_id"
    t.integer  "doctor_id"
    t.integer  "round_id"
    t.integer  "duration"
    t.datetime "start"
    t.datetime "finish"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "claimable"
  end

  create_table "hospitals", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.boolean  "showtime"
    t.integer  "duration"
    t.string   "item"
  end

  create_table "patients", :force => true do |t|
    t.string   "name"
    t.integer  "ward_id"
    t.date     "admission"
    t.date     "discharge"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "reason"
    t.text     "note"
    t.string   "mrn"
    t.integer  "status"
    t.integer  "under"
  end

  create_table "rounds", :force => true do |t|
    t.integer  "doctor_id"
    t.integer  "hospital_id"
    t.date     "date"
    t.integer  "duration"
    t.integer  "claimable"
    t.datetime "start"
    t.datetime "finish"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "number"
  end

  create_table "visits", :force => true do |t|
    t.integer  "patient_id"
    t.integer  "doctor_id"
    t.integer  "ward_id"
    t.date     "date"
    t.integer  "duration"
    t.string   "item"
    t.text     "notes"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "claim_id"
  end

  create_table "wards", :force => true do |t|
    t.integer  "hospital_id"
    t.string   "name"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

end
