class NewMigrationToSwitchToPostgreSql < ActiveRecord::Migration[5.2]
  def change
    create_table "categories", force: :cascade do |t|
      t.string "name"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end

    create_table "orders", force: :cascade do |t|
      t.integer "amount_cents", default: 0, null: false
      t.json "payment"
      t.integer "user_id"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.boolean "paid", default: false
      t.index ["user_id"], name: "index_orders_on_user_id"
    end

    create_table "orders_products", id: false, force: :cascade do |t|
      t.integer "order_id", null: false
      t.integer "product_id", null: false
      t.index ["order_id", "product_id"], name: "index_orders_products_on_order_id_and_product_id"
      t.index ["product_id", "order_id"], name: "index_orders_products_on_product_id_and_order_id"
    end

    create_table "products", force: :cascade do |t|
      t.string "name"
      t.text "description"
      t.boolean "ordinable", default: true
      t.integer "user_id"
      t.integer "category_id"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.integer "price_cents", default: 0, null: false
      t.index ["category_id"], name: "index_products_on_category_id"
      t.index ["user_id"], name: "index_products_on_user_id"
    end

    create_table "users", force: :cascade do |t|
      t.string "email", default: "", null: false
      t.string "encrypted_password", default: "", null: false
      t.string "reset_password_token"
      t.datetime "reset_password_sent_at"
      t.datetime "remember_created_at"
      t.integer "sign_in_count", default: 0, null: false
      t.datetime "current_sign_in_at"
      t.datetime "last_sign_in_at"
      t.string "current_sign_in_ip"
      t.string "last_sign_in_ip"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.boolean "admin", default: false
      t.index ["email"], name: "index_users_on_email", unique: true
      t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    end
  end
end
