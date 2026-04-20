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

ActiveRecord::Schema[7.1].define(version: 2026_04_20_120338) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "emergency_contacts", force: :cascade do |t|
    t.string "name_en"
    t.string "name_jp"
    t.string "number"
    t.string "description_en"
    t.string "description_jp"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "hospital_services", force: :cascade do |t|
    t.bigint "hospital_id", null: false
    t.bigint "service_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["hospital_id"], name: "index_hospital_services_on_hospital_id"
    t.index ["service_id"], name: "index_hospital_services_on_service_id"
  end

  create_table "hospital_specialties", force: :cascade do |t|
    t.bigint "hospital_id", null: false
    t.bigint "specialty_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["hospital_id"], name: "index_hospital_specialties_on_hospital_id"
    t.index ["specialty_id"], name: "index_hospital_specialties_on_specialty_id"
  end

  create_table "hospitals", force: :cascade do |t|
    t.string "name_en"
    t.string "name_jp"
    t.string "address_en"
    t.string "address_jp"
    t.string "phone"
    t.string "website_url"
    t.string "ward"
    t.float "latitude"
    t.float "longitude"
    t.string "visiting_hours"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_government"
    t.boolean "is_certified"
    t.boolean "accepts_shakai_hoken"
    t.boolean "accepts_kokumin_hoken"
    t.boolean "accepts_travel_insurance"
    t.string "insurance_notes_en"
    t.string "insurance_notes_jp"
    t.text "departments"
  end

  create_table "insurance_guides", force: :cascade do |t|
    t.string "title_en"
    t.string "title_jp"
    t.text "body_en"
    t.text "body_jp"
    t.string "insurance_type"
    t.integer "coverage_percent"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "services", force: :cascade do |t|
    t.string "name_en"
    t.string "name_jp"
    t.string "category"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "specialties", force: :cascade do |t|
    t.string "name_en"
    t.string "name_jp"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "hospital_services", "hospitals"
  add_foreign_key "hospital_services", "services"
  add_foreign_key "hospital_specialties", "hospitals"
  add_foreign_key "hospital_specialties", "specialties"
end
