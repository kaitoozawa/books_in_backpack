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

ActiveRecord::Schema.define(version: 20180611165235) do

  create_table "books", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.string   "image"
    t.string   "title"
    t.string   "author"
    t.string   "language"
    t.integer  "page"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["user_id"], name: "index_books_on_user_id", using: :btree
  end

  create_table "countries", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "messages", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.integer  "recipient_id"
    t.string   "content"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["recipient_id"], name: "index_messages_on_recipient_id", using: :btree
    t.index ["user_id"], name: "index_messages_on_user_id", using: :btree
  end

  create_table "mylocations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "country_id"
    t.string   "city"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["country_id"], name: "index_mylocations_on_country_id", using: :btree
  end

  create_table "profiles", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.string   "image"
    t.string   "name"
    t.string   "nationality"
    t.string   "gender"
    t.integer  "age"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["user_id"], name: "index_profiles_on_user_id", using: :btree
  end

  create_table "relationshipmessages", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.integer  "m_request_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["m_request_id"], name: "index_relationshipmessages_on_m_request_id", using: :btree
    t.index ["user_id", "m_request_id"], name: "index_relationshipmessages_on_user_id_and_m_request_id", unique: true, using: :btree
    t.index ["user_id"], name: "index_relationshipmessages_on_user_id", using: :btree
  end

  create_table "relationships", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.integer  "request_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["request_id"], name: "index_relationships_on_request_id", using: :btree
    t.index ["user_id", "request_id"], name: "index_relationships_on_user_id_and_request_id", unique: true, using: :btree
    t.index ["user_id"], name: "index_relationships_on_user_id", using: :btree
  end

  create_table "trade1s", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.integer  "trader_id"
    t.string   "answer"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["trader_id"], name: "index_trade1s_on_trader_id", using: :btree
    t.index ["user_id", "trader_id"], name: "index_trade1s_on_user_id_and_trader_id", unique: true, using: :btree
    t.index ["user_id"], name: "index_trade1s_on_user_id", using: :btree
  end

  create_table "trade2s", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.integer  "trader_id"
    t.string   "answer"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["trader_id"], name: "index_trade2s_on_trader_id", using: :btree
    t.index ["user_id", "trader_id"], name: "index_trade2s_on_user_id_and_trader_id", unique: true, using: :btree
    t.index ["user_id"], name: "index_trade2s_on_user_id", using: :btree
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "mylocation_id"
    t.integer  "message_user_id"
    t.index ["mylocation_id"], name: "index_users_on_mylocation_id", using: :btree
  end

  add_foreign_key "books", "users"
  add_foreign_key "messages", "users"
  add_foreign_key "messages", "users", column: "recipient_id"
  add_foreign_key "mylocations", "countries"
  add_foreign_key "profiles", "users"
  add_foreign_key "relationshipmessages", "users"
  add_foreign_key "relationshipmessages", "users", column: "m_request_id"
  add_foreign_key "relationships", "users"
  add_foreign_key "relationships", "users", column: "request_id"
  add_foreign_key "trade1s", "users"
  add_foreign_key "trade1s", "users", column: "trader_id"
  add_foreign_key "trade2s", "users"
  add_foreign_key "trade2s", "users", column: "trader_id"
  add_foreign_key "users", "mylocations"
end
