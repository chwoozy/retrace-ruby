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

ActiveRecord::Schema.define(version: 2021_12_22_150546) do

  create_table "customers", id: :integer, charset: "utf8mb3", force: :cascade do |t|
    t.string "company", limit: 50
    t.string "last_name", limit: 50
    t.string "first_name", limit: 50
    t.string "email_address", limit: 50
    t.string "job_title", limit: 50
    t.string "business_phone", limit: 25
    t.string "home_phone", limit: 25
    t.string "mobile_phone", limit: 25
    t.string "fax_number", limit: 25
    t.text "address", size: :long
    t.string "city", limit: 50
    t.string "state_province", limit: 50
    t.string "zip_postal_code", limit: 15
    t.string "country_region", limit: 50
    t.text "web_page", size: :long
    t.text "notes", size: :long
    t.binary "attachments", size: :long
    t.index ["city"], name: "city"
    t.index ["company"], name: "company"
    t.index ["first_name"], name: "first_name"
    t.index ["last_name"], name: "last_name"
    t.index ["state_province"], name: "state_province"
    t.index ["zip_postal_code"], name: "zip_postal_code"
  end

  create_table "employee_privileges", primary_key: ["employee_id", "privilege_id"], charset: "utf8mb3", force: :cascade do |t|
    t.integer "employee_id", null: false
    t.integer "privilege_id", null: false
    t.index ["employee_id"], name: "employee_id"
    t.index ["privilege_id"], name: "privilege_id"
    t.index ["privilege_id"], name: "privilege_id_2"
  end

  create_table "employees", id: :integer, charset: "utf8mb3", force: :cascade do |t|
    t.string "company", limit: 50
    t.string "last_name", limit: 50
    t.string "first_name", limit: 50
    t.string "email_address", limit: 50
    t.string "job_title", limit: 50
    t.string "business_phone", limit: 25
    t.string "home_phone", limit: 25
    t.string "mobile_phone", limit: 25
    t.string "fax_number", limit: 25
    t.text "address", size: :long
    t.string "city", limit: 50
    t.string "state_province", limit: 50
    t.string "zip_postal_code", limit: 15
    t.string "country_region", limit: 50
    t.text "web_page", size: :long
    t.text "notes", size: :long
    t.binary "attachments", size: :long
    t.index ["city"], name: "city"
    t.index ["company"], name: "company"
    t.index ["first_name"], name: "first_name"
    t.index ["last_name"], name: "last_name"
    t.index ["state_province"], name: "state_province"
    t.index ["zip_postal_code"], name: "zip_postal_code"
  end

  create_table "inventory_transaction_types", id: { type: :integer, limit: 1, default: nil }, charset: "utf8mb3", force: :cascade do |t|
    t.string "type_name", limit: 50, null: false
  end

  create_table "inventory_transactions", id: :integer, charset: "utf8mb3", force: :cascade do |t|
    t.integer "transaction_type", limit: 1, null: false
    t.datetime "transaction_created_date"
    t.datetime "transaction_modified_date"
    t.integer "product_id", null: false
    t.integer "quantity", null: false
    t.integer "purchase_order_id"
    t.integer "customer_order_id"
    t.string "comments"
    t.index ["customer_order_id"], name: "customer_order_id"
    t.index ["customer_order_id"], name: "customer_order_id_2"
    t.index ["product_id"], name: "product_id"
    t.index ["product_id"], name: "product_id_2"
    t.index ["purchase_order_id"], name: "purchase_order_id"
    t.index ["purchase_order_id"], name: "purchase_order_id_2"
    t.index ["transaction_type"], name: "transaction_type"
  end

  create_table "invoices", id: :integer, charset: "utf8mb3", force: :cascade do |t|
    t.integer "order_id"
    t.datetime "invoice_date"
    t.datetime "due_date"
    t.decimal "tax", precision: 19, scale: 4, default: "0.0"
    t.decimal "shipping", precision: 19, scale: 4, default: "0.0"
    t.decimal "amount_due", precision: 19, scale: 4, default: "0.0"
    t.index ["id"], name: "id"
    t.index ["id"], name: "id_2"
    t.index ["order_id"], name: "fk_invoices_orders1_idx"
  end

  create_table "order_details", id: :integer, charset: "utf8mb3", force: :cascade do |t|
    t.integer "order_id", null: false
    t.integer "product_id"
    t.decimal "quantity", precision: 18, scale: 4, default: "0.0", null: false
    t.decimal "unit_price", precision: 19, scale: 4, default: "0.0"
    t.float "discount", limit: 53, default: 0.0, null: false
    t.integer "status_id"
    t.datetime "date_allocated"
    t.integer "purchase_order_id"
    t.integer "inventory_id"
    t.index ["id"], name: "id"
    t.index ["id"], name: "id_2"
    t.index ["id"], name: "id_3"
    t.index ["id"], name: "id_4"
    t.index ["id"], name: "id_5"
    t.index ["inventory_id"], name: "inventory_id"
    t.index ["order_id"], name: "fk_order_details_orders1_idx"
    t.index ["product_id"], name: "product_id"
    t.index ["product_id"], name: "product_id_2"
    t.index ["purchase_order_id"], name: "purchase_order_id"
    t.index ["status_id"], name: "fk_order_details_order_details_status1_idx"
  end

  create_table "order_details_status", id: :integer, default: nil, charset: "utf8mb3", force: :cascade do |t|
    t.string "status_name", limit: 50, null: false
  end

  create_table "orders", id: :integer, charset: "utf8mb3", force: :cascade do |t|
    t.integer "employee_id"
    t.integer "customer_id"
    t.datetime "order_date"
    t.datetime "shipped_date"
    t.integer "shipper_id"
    t.string "ship_name", limit: 50
    t.text "ship_address", size: :long
    t.string "ship_city", limit: 50
    t.string "ship_state_province", limit: 50
    t.string "ship_zip_postal_code", limit: 50
    t.string "ship_country_region", limit: 50
    t.decimal "shipping_fee", precision: 19, scale: 4, default: "0.0"
    t.decimal "taxes", precision: 19, scale: 4, default: "0.0"
    t.string "payment_type", limit: 50
    t.datetime "paid_date"
    t.text "notes", size: :long
    t.float "tax_rate", limit: 53, default: 0.0
    t.integer "tax_status_id", limit: 1
    t.integer "status_id", limit: 1, default: 0
    t.index ["customer_id"], name: "customer_id"
    t.index ["customer_id"], name: "customer_id_2"
    t.index ["employee_id"], name: "employee_id"
    t.index ["employee_id"], name: "employee_id_2"
    t.index ["id"], name: "id"
    t.index ["id"], name: "id_2"
    t.index ["id"], name: "id_3"
    t.index ["ship_zip_postal_code"], name: "ship_zip_postal_code"
    t.index ["shipper_id"], name: "shipper_id"
    t.index ["shipper_id"], name: "shipper_id_2"
    t.index ["status_id"], name: "fk_orders_orders_status1"
    t.index ["tax_status_id"], name: "tax_status"
  end

  create_table "orders_status", id: { type: :integer, limit: 1, default: nil }, charset: "utf8mb3", force: :cascade do |t|
    t.string "status_name", limit: 50, null: false
  end

  create_table "orders_tax_status", id: { type: :integer, limit: 1, default: nil }, charset: "utf8mb3", force: :cascade do |t|
    t.string "tax_status_name", limit: 50, null: false
  end

  create_table "privileges", id: :integer, charset: "utf8mb3", force: :cascade do |t|
    t.string "privilege_name", limit: 50
  end

  create_table "products", id: :integer, charset: "utf8mb3", force: :cascade do |t|
    t.text "supplier_ids", size: :long
    t.string "product_code", limit: 25
    t.string "product_name", limit: 50
    t.text "description", size: :long
    t.decimal "standard_cost", precision: 19, scale: 4, default: "0.0"
    t.decimal "list_price", precision: 19, scale: 4, default: "0.0", null: false
    t.integer "reorder_level"
    t.integer "target_level"
    t.string "quantity_per_unit", limit: 50
    t.boolean "discontinued", default: false, null: false
    t.integer "minimum_reorder_quantity"
    t.string "category", limit: 50
    t.binary "attachments", size: :long
    t.index ["product_code"], name: "product_code"
  end

  create_table "purchase_order_details", id: :integer, charset: "utf8mb3", force: :cascade do |t|
    t.integer "purchase_order_id", null: false
    t.integer "product_id"
    t.decimal "quantity", precision: 18, scale: 4, null: false
    t.decimal "unit_cost", precision: 19, scale: 4, null: false
    t.datetime "date_received"
    t.boolean "posted_to_inventory", default: false, null: false
    t.integer "inventory_id"
    t.index ["id"], name: "id"
    t.index ["inventory_id"], name: "inventory_id"
    t.index ["inventory_id"], name: "inventory_id_2"
    t.index ["product_id"], name: "product_id"
    t.index ["product_id"], name: "product_id_2"
    t.index ["purchase_order_id"], name: "purchase_order_id"
    t.index ["purchase_order_id"], name: "purchase_order_id_2"
  end

  create_table "purchase_order_status", id: :integer, default: nil, charset: "utf8mb3", force: :cascade do |t|
    t.string "status", limit: 50
  end

  create_table "purchase_orders", id: :integer, charset: "utf8mb3", force: :cascade do |t|
    t.integer "supplier_id"
    t.integer "created_by"
    t.datetime "submitted_date"
    t.datetime "creation_date"
    t.integer "status_id", default: 0
    t.datetime "expected_date"
    t.decimal "shipping_fee", precision: 19, scale: 4, default: "0.0", null: false
    t.decimal "taxes", precision: 19, scale: 4, default: "0.0", null: false
    t.datetime "payment_date"
    t.decimal "payment_amount", precision: 19, scale: 4, default: "0.0"
    t.string "payment_method", limit: 50
    t.text "notes", size: :long
    t.integer "approved_by"
    t.datetime "approved_date"
    t.integer "submitted_by"
    t.index ["created_by"], name: "created_by"
    t.index ["id"], name: "id", unique: true
    t.index ["id"], name: "id_2"
    t.index ["status_id"], name: "status_id"
    t.index ["supplier_id"], name: "supplier_id"
    t.index ["supplier_id"], name: "supplier_id_2"
  end

  create_table "sales_reports", primary_key: "group_by", id: { type: :string, limit: 50 }, charset: "utf8mb3", force: :cascade do |t|
    t.string "display", limit: 50
    t.string "title", limit: 50
    t.text "filter_row_source", size: :long
    t.boolean "default", default: false, null: false
  end

  create_table "shippers", id: :integer, charset: "utf8mb3", force: :cascade do |t|
    t.string "company", limit: 50
    t.string "last_name", limit: 50
    t.string "first_name", limit: 50
    t.string "email_address", limit: 50
    t.string "job_title", limit: 50
    t.string "business_phone", limit: 25
    t.string "home_phone", limit: 25
    t.string "mobile_phone", limit: 25
    t.string "fax_number", limit: 25
    t.text "address", size: :long
    t.string "city", limit: 50
    t.string "state_province", limit: 50
    t.string "zip_postal_code", limit: 15
    t.string "country_region", limit: 50
    t.text "web_page", size: :long
    t.text "notes", size: :long
    t.binary "attachments", size: :long
    t.index ["city"], name: "city"
    t.index ["company"], name: "company"
    t.index ["first_name"], name: "first_name"
    t.index ["last_name"], name: "last_name"
    t.index ["state_province"], name: "state_province"
    t.index ["zip_postal_code"], name: "zip_postal_code"
  end

  create_table "strings", primary_key: "string_id", id: :integer, charset: "utf8mb3", force: :cascade do |t|
    t.string "string_data"
  end

  create_table "suppliers", id: :integer, charset: "utf8mb3", force: :cascade do |t|
    t.string "company", limit: 50
    t.string "last_name", limit: 50
    t.string "first_name", limit: 50
    t.string "email_address", limit: 50
    t.string "job_title", limit: 50
    t.string "business_phone", limit: 25
    t.string "home_phone", limit: 25
    t.string "mobile_phone", limit: 25
    t.string "fax_number", limit: 25
    t.text "address", size: :long
    t.string "city", limit: 50
    t.string "state_province", limit: 50
    t.string "zip_postal_code", limit: 15
    t.string "country_region", limit: 50
    t.text "web_page", size: :long
    t.text "notes", size: :long
    t.binary "attachments", size: :long
    t.index ["city"], name: "city"
    t.index ["company"], name: "company"
    t.index ["first_name"], name: "first_name"
    t.index ["last_name"], name: "last_name"
    t.index ["state_province"], name: "state_province"
    t.index ["zip_postal_code"], name: "zip_postal_code"
  end

  add_foreign_key "employee_privileges", "employees", name: "fk_employee_privileges_employees1"
  add_foreign_key "employee_privileges", "privileges", name: "fk_employee_privileges_privileges1"
  add_foreign_key "inventory_transactions", "inventory_transaction_types", column: "transaction_type", name: "fk_inventory_transactions_inventory_transaction_types1"
  add_foreign_key "inventory_transactions", "orders", column: "customer_order_id", name: "fk_inventory_transactions_orders1"
  add_foreign_key "inventory_transactions", "products", name: "fk_inventory_transactions_products1"
  add_foreign_key "inventory_transactions", "purchase_orders", name: "fk_inventory_transactions_purchase_orders1"
  add_foreign_key "invoices", "orders", name: "fk_invoices_orders1"
  add_foreign_key "order_details", "order_details_status", column: "status_id", name: "fk_order_details_order_details_status1"
  add_foreign_key "order_details", "orders", name: "fk_order_details_orders1"
  add_foreign_key "order_details", "products", name: "fk_order_details_products1"
  add_foreign_key "orders", "customers", name: "fk_orders_customers"
  add_foreign_key "orders", "employees", name: "fk_orders_employees1"
  add_foreign_key "orders", "orders_status", column: "status_id", name: "fk_orders_orders_status1"
  add_foreign_key "orders", "orders_tax_status", column: "tax_status_id", name: "fk_orders_orders_tax_status1"
  add_foreign_key "orders", "shippers", name: "fk_orders_shippers1"
  add_foreign_key "purchase_order_details", "inventory_transactions", column: "inventory_id", name: "fk_purchase_order_details_inventory_transactions1"
  add_foreign_key "purchase_order_details", "products", name: "fk_purchase_order_details_products1"
  add_foreign_key "purchase_order_details", "purchase_orders", name: "fk_purchase_order_details_purchase_orders1"
  add_foreign_key "purchase_orders", "employees", column: "created_by", name: "fk_purchase_orders_employees1"
  add_foreign_key "purchase_orders", "purchase_order_status", column: "status_id", name: "fk_purchase_orders_purchase_order_status1"
  add_foreign_key "purchase_orders", "suppliers", name: "fk_purchase_orders_suppliers1"
end
