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

ActiveRecord::Schema.define(version: 20170530085652) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "basket_lines", force: :cascade do |t|
    t.integer "product_id"
    t.integer "user_id"
    t.index ["product_id"], name: "index_basket_lines_on_product_id", using: :btree
    t.index ["user_id"], name: "index_basket_lines_on_user_id", using: :btree
  end

  create_table "producer_awards", force: :cascade do |t|
    t.string  "name"
    t.string  "year"
    t.integer "producer_id"
    t.index ["producer_id"], name: "index_producer_awards_on_producer_id", using: :btree
  end

  create_table "producer_reviews", force: :cascade do |t|
    t.text    "content"
    t.integer "mark"
    t.integer "user_id"
    t.integer "producer_id"
    t.index ["producer_id"], name: "index_producer_reviews_on_producer_id", using: :btree
    t.index ["user_id"], name: "index_producer_reviews_on_user_id", using: :btree
  end

  create_table "producers", force: :cascade do |t|
    t.string  "name"
    t.string  "address"
    t.string  "zipcode"
    t.string  "city"
    t.text    "description"
    t.string  "phone"
    t.string  "mobile_phone"
    t.string  "company_email"
    t.string  "category"
    t.integer "user_id"
    t.index ["user_id"], name: "index_producers_on_user_id", using: :btree
  end

  create_table "product_awards", force: :cascade do |t|
    t.string  "name"
    t.string  "year"
    t.integer "product_id"
    t.index ["product_id"], name: "index_product_awards_on_product_id", using: :btree
  end

  create_table "products", force: :cascade do |t|
    t.string  "name"
    t.string  "description"
    t.integer "price"
    t.integer "producer_id"
    t.index ["producer_id"], name: "index_products_on_producer_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "first_name"
    t.string   "last_name"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "basket_lines", "products"
  add_foreign_key "basket_lines", "users"
  add_foreign_key "producer_awards", "producers"
  add_foreign_key "producer_reviews", "producers"
  add_foreign_key "producer_reviews", "users"
  add_foreign_key "producers", "users"
  add_foreign_key "product_awards", "products"
  add_foreign_key "products", "producers"
end
