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

ActiveRecord::Schema.define(version: 2024_11_13_103310) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cities", force: :cascade do |t|
    t.string "name"
    t.bigint "zone_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["zone_id"], name: "index_cities_on_zone_id"
  end

  create_table "cities_users", id: false, force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "city_id", null: false
    t.index ["city_id"], name: "index_cities_users_on_city_id"
    t.index ["user_id", "city_id"], name: "index_cities_users_on_user_id_and_city_id", unique: true
    t.index ["user_id"], name: "index_cities_users_on_user_id"
  end

  create_table "institutes", force: :cascade do |t|
    t.string "name_of_head_of_institution"
    t.string "institute_contact_no"
    t.string "institute_email_id"
    t.integer "number_of_schools_in_group"
    t.string "name_of_influencer_decision_maker"
    t.string "designation"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "opportunities", force: :cascade do |t|
    t.bigint "school_id", null: false
    t.bigint "product_id", null: false
    t.datetime "start_date", null: false
    t.string "contact_person"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "sales_team_id"
    t.index ["product_id"], name: "index_opportunities_on_product_id"
    t.index ["sales_team_id"], name: "index_opportunities_on_sales_team_id"
    t.index ["school_id"], name: "index_opportunities_on_school_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "product_name"
    t.text "description"
    t.string "supplier"
    t.string "unit"
    t.decimal "price", precision: 10, scale: 2
    t.datetime "date"
    t.json "available_days", default: []
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "sales_teams", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "designation", null: false
    t.bigint "manager_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "schools", force: :cascade do |t|
    t.string "name"
    t.string "lead_source"
    t.string "location"
    t.string "city"
    t.string "state"
    t.string "pincode"
    t.integer "number_of_students"
    t.decimal "avg_fees", precision: 10, scale: 2
    t.string "board"
    t.string "website"
    t.boolean "part_of_group_school"
    t.bigint "institute_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["institute_id"], name: "index_schools_on_institute_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "mobile_number"
    t.string "email_id"
    t.bigint "reporting_manager_id"
    t.index ["email_id"], name: "index_users_on_email_id", unique: true
  end

  create_table "users_zones", id: false, force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "zone_id", null: false
    t.index ["user_id", "zone_id"], name: "index_users_zones_on_user_id_and_zone_id", unique: true
    t.index ["user_id"], name: "index_users_zones_on_user_id"
    t.index ["zone_id"], name: "index_users_zones_on_zone_id"
  end

  create_table "zones", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "cities", "zones"
  add_foreign_key "cities_users", "cities"
  add_foreign_key "cities_users", "users"
  add_foreign_key "opportunities", "products"
  add_foreign_key "opportunities", "sales_teams"
  add_foreign_key "opportunities", "schools"
  add_foreign_key "sales_teams", "users"
  add_foreign_key "sales_teams", "users", column: "manager_id"
  add_foreign_key "schools", "institutes"
  add_foreign_key "users", "users", column: "reporting_manager_id"
  add_foreign_key "users_zones", "users"
  add_foreign_key "users_zones", "zones"
end
