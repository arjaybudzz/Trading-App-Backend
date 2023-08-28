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

ActiveRecord::Schema[7.0].define(version: 2023_08_26_035554) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string "username"
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["username"], name: "index_admins_on_username", unique: true
  end

  create_table "tickers", force: :cascade do |t|
    t.string "symbol"
    t.decimal "last_price", default: "0.0"
    t.decimal "volume"
    t.bigint "trader_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "latest_price", default: "0.0"
    t.string "time_stamp"
    t.integer "share"
    t.index ["trader_id"], name: "index_tickers_on_trader_id"
  end

  create_table "traders", force: :cascade do |t|
    t.string "username"
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "country"
    t.decimal "balance", default: "10000.0"
    t.boolean "approved", default: false
    t.bigint "admin_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.index ["admin_id"], name: "index_traders_on_admin_id"
    t.index ["email"], name: "index_traders_on_email", unique: true
    t.index ["username"], name: "index_traders_on_username", unique: true
  end

  create_table "transactions", force: :cascade do |t|
    t.string "stock"
    t.decimal "profit", default: "0.0"
    t.decimal "percent", default: "0.0"
    t.bigint "ticker_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "action"
    t.index ["ticker_id"], name: "index_transactions_on_ticker_id"
  end

  add_foreign_key "tickers", "traders"
  add_foreign_key "traders", "admins"
  add_foreign_key "transactions", "tickers"
end
