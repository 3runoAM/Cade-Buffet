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

ActiveRecord::Schema[7.1].define(version: 2024_05_02_151538) do
  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "addresses", force: :cascade do |t|
    t.string "street_name", null: false
    t.string "neighborhood", null: false
    t.string "house_or_lot_number", null: false
    t.string "state", null: false
    t.string "city", null: false
    t.string "zip", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "buffet_id"
    t.index ["buffet_id"], name: "index_addresses_on_buffet_id"
  end

  create_table "buffet_payment_methods", force: :cascade do |t|
    t.integer "payment_method_id", null: false
    t.integer "buffet_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["buffet_id"], name: "index_buffet_payment_methods_on_buffet_id"
    t.index ["payment_method_id"], name: "index_buffet_payment_methods_on_payment_method_id"
  end

  create_table "buffets", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "brand_name", null: false
    t.string "company_name", null: false
    t.string "crn", null: false
    t.string "phone", null: false
    t.string "email", null: false
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_buffets_on_user_id"
  end

  create_table "event_prices", force: :cascade do |t|
    t.integer "standard_price", null: false
    t.integer "extra_guest_price", null: false
    t.integer "extra_hour_price", null: false
    t.integer "day_type", null: false
    t.integer "event_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_event_prices_on_event_id"
  end

  create_table "events", force: :cascade do |t|
    t.string "name", null: false
    t.string "description", null: false
    t.integer "min_guests", null: false
    t.integer "max_guests", null: false
    t.integer "standard_duration", null: false
    t.string "menu", null: false
    t.boolean "offsite_event", null: false
    t.boolean "offers_alcohol", null: false
    t.boolean "offers_decoration", null: false
    t.boolean "offers_valet_parking", null: false
    t.integer "buffet_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["buffet_id"], name: "index_events_on_buffet_id"
  end

  create_table "orders", force: :cascade do |t|
    t.integer "buffet_id", null: false
    t.integer "event_id", null: false
    t.date "event_date", null: false
    t.integer "total_guests", null: false
    t.string "address"
    t.string "additional_info"
    t.string "code", null: false
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.integer "price", null: false
    t.integer "payment_method_id"
    t.integer "adjustment"
    t.string "adjustment_description"
    t.date "confirmation_date"
    t.integer "adjustment_type", default: 0
    t.index ["buffet_id"], name: "index_orders_on_buffet_id"
    t.index ["event_id"], name: "index_orders_on_event_id"
    t.index ["payment_method_id"], name: "index_orders_on_payment_method_id"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "payment_methods", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name"
    t.integer "role", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "cpf"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "addresses", "buffets"
  add_foreign_key "buffet_payment_methods", "buffets"
  add_foreign_key "buffet_payment_methods", "payment_methods"
  add_foreign_key "buffets", "users"
  add_foreign_key "event_prices", "events"
  add_foreign_key "events", "buffets"
  add_foreign_key "orders", "buffets"
  add_foreign_key "orders", "events"
  add_foreign_key "orders", "payment_methods"
  add_foreign_key "orders", "users"
end
