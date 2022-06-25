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

ActiveRecord::Schema[7.0].define(version: 2022_06_25_095232) do
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

  create_table "albums", force: :cascade do |t|
    t.string "name"
    t.string "summary"
    t.string "coverimg"
    t.integer "user_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "csize"
    t.string "ussize"
    t.string "brand"
    t.text "dnote"
    t.text "description"
    t.string "dname"
    t.string "fullname"
    t.text "keywords"
    t.text "points"
    t.text "price"
    t.text "stock"
    t.text "asize"
    t.string "fabric_type"
    t.text "package"
    t.text "weight"
    t.index ["user_id", "created_at"], name: "index_albums_on_user_id_and_created_at"
    t.index ["user_id"], name: "index_albums_on_user_id"
  end

  create_table "amagroups", force: :cascade do |t|
    t.string "name"
    t.text "remark"
    t.boolean "isused"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_amagroups_on_user_id"
  end

  create_table "amagroupwithas", force: :cascade do |t|
    t.integer "amagroup_id", null: false
    t.integer "amatemp_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["amagroup_id"], name: "index_amagroupwithas_on_amagroup_id"
    t.index ["amatemp_id"], name: "index_amagroupwithas_on_amatemp_id"
  end

  create_table "amatemps", force: :cascade do |t|
    t.string "name"
    t.text "value"
    t.boolean "isused"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_amatemps_on_user_id"
  end

  create_table "amatwithas", force: :cascade do |t|
    t.string "value"
    t.integer "album_id", null: false
    t.integer "amatemp_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["album_id"], name: "index_amatwithas_on_album_id"
    t.index ["amatemp_id"], name: "index_amatwithas_on_amatemp_id"
  end

  create_table "etemplates", force: :cascade do |t|
    t.string "name"
    t.text "title"
    t.boolean "isused"
    t.integer "user_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["user_id"], name: "index_etemplates_on_user_id"
  end

  create_table "inoutplans", force: :cascade do |t|
    t.string "name"
    t.text "inout"
    t.integer "user_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.boolean "actived"
    t.string "presku"
    t.integer "warehouse_id"
    t.index ["user_id"], name: "index_inoutplans_on_user_id"
    t.index ["warehouse_id"], name: "index_inoutplans_on_warehouse_id"
  end

  create_table "inoutstocks", force: :cascade do |t|
    t.string "sku"
    t.integer "normal"
    t.integer "sizeup"
    t.integer "sizedown"
    t.integer "defect"
    t.boolean "actived"
    t.integer "inoutplan_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["inoutplan_id"], name: "index_inoutstocks_on_inoutplan_id"
  end

  create_table "inventories", force: :cascade do |t|
    t.string "sku"
    t.integer "normal"
    t.integer "sizeup"
    t.integer "sizedown"
    t.integer "defect"
    t.string "parentsku"
    t.string "name"
    t.integer "user_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "warehouse_id"
    t.index ["user_id"], name: "index_inventories_on_user_id"
    t.index ["warehouse_id"], name: "index_inventories_on_warehouse_id"
  end

  create_table "kwords", force: :cascade do |t|
    t.string "name"
    t.text "instr"
    t.text "outstr"
    t.string "lefwords"
    t.integer "user_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["user_id"], name: "index_kwords_on_user_id"
  end

  create_table "microposts", force: :cascade do |t|
    t.text "content"
    t.integer "user_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "picture"
    t.index ["user_id", "created_at"], name: "index_microposts_on_user_id_and_created_at"
    t.index ["user_id"], name: "index_microposts_on_user_id"
  end

  create_table "photos", force: :cascade do |t|
    t.string "name"
    t.integer "album_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "picture"
    t.string "qquuid"
    t.index ["album_id"], name: "index_photos_on_album_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.string "sku"
    t.integer "parentid"
    t.text "description"
    t.integer "user_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["user_id"], name: "index_products_on_user_id"
  end

  create_table "relationships", force: :cascade do |t|
    t.integer "follower_id"
    t.integer "followed_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["followed_id"], name: "index_relationships_on_followed_id"
    t.index ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true
    t.index ["follower_id"], name: "index_relationships_on_follower_id"
  end

  create_table "upcs", force: :cascade do |t|
    t.string "name"
    t.string "bool"
    t.string "isused"
    t.integer "user_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["user_id"], name: "index_upcs_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "password_digest"
    t.string "remember_digest"
    t.boolean "admin"
    t.string "activation_digest"
    t.boolean "activated", default: false
    t.datetime "activated_at", precision: nil
    t.string "reset_digest"
    t.datetime "reset_sent_at", precision: nil
    t.string "brand"
    t.text "note"
    t.string "imgrule"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  create_table "warehouses", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.boolean "isused"
    t.integer "user_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.boolean "is_current"
    t.index ["user_id"], name: "index_warehouses_on_user_id"
  end

  create_table "xstockplans", force: :cascade do |t|
    t.string "name"
    t.integer "user_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["user_id"], name: "index_xstockplans_on_user_id"
  end

  create_table "xstocks", force: :cascade do |t|
    t.string "sku"
    t.string "fnsku"
    t.integer "homenum"
    t.integer "fbanum"
    t.integer "monthsold"
    t.string "parentsku"
    t.integer "xstockplan_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "name"
    t.integer "plannum"
    t.index ["xstockplan_id"], name: "index_xstocks_on_xstockplan_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "albums", "users"
  add_foreign_key "amagroups", "users"
  add_foreign_key "amagroupwithas", "amagroups"
  add_foreign_key "amagroupwithas", "amatemps"
  add_foreign_key "amatemps", "users"
  add_foreign_key "amatwithas", "albums"
  add_foreign_key "amatwithas", "amatemps"
  add_foreign_key "etemplates", "users"
  add_foreign_key "inoutplans", "users"
  add_foreign_key "inoutplans", "warehouses"
  add_foreign_key "inoutstocks", "inoutplans"
  add_foreign_key "inventories", "users"
  add_foreign_key "inventories", "warehouses"
  add_foreign_key "kwords", "users"
  add_foreign_key "microposts", "users"
  add_foreign_key "photos", "albums"
  add_foreign_key "products", "users"
  add_foreign_key "upcs", "users"
  add_foreign_key "warehouses", "users"
  add_foreign_key "xstockplans", "users"
  add_foreign_key "xstocks", "xstockplans"
end
