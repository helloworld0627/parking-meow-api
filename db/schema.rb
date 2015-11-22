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

ActiveRecord::Schema.define(version: 20151118064552) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "api_request_schedules", force: :cascade do |t|
    t.string   "file_path"
    t.string   "request_url",             null: false
    t.integer  "status",      default: 0
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "parking_business_hours", force: :cascade do |t|
    t.integer  "hour_type",      default: 0
    t.string   "from_to"
    t.integer  "parking_lot_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "parking_business_hours", ["parking_lot_id"], name: "index_parking_business_hours_on_parking_lot_id", using: :btree

  create_table "parking_lots", force: :cascade do |t|
    t.integer  "objectid"
    t.integer  "buslic_location_id"
    t.string   "dea_facility_address"
    t.integer  "dea_stalls"
    t.string   "fac_name"
    t.integer  "disabled"
    t.string   "op_name"
    t.string   "op_phone"
    t.string   "op_phone2"
    t.string   "op_web"
    t.integer  "payment_type",                                  default: 0
    t.integer  "other_type",                                    default: 0
    t.string   "webname"
    t.integer  "regionid"
    t.integer  "outofserv_type",                                default: 0
    t.integer  "vacant"
    t.string   "signid"
    t.decimal  "longtitude",           precision: 12, scale: 9
    t.decimal  "latitude",             precision: 12, scale: 9
    t.datetime "created_at",                                                null: false
    t.datetime "updated_at",                                                null: false
  end

  create_table "parking_rates", force: :cascade do |t|
    t.integer  "rate_type",      default: 0
    t.decimal  "price"
    t.string   "description"
    t.integer  "parking_lot_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "parking_rates", ["parking_lot_id"], name: "index_parking_rates_on_parking_lot_id", using: :btree

  add_foreign_key "parking_business_hours", "parking_lots"
  add_foreign_key "parking_rates", "parking_lots"
end
