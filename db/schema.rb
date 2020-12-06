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

ActiveRecord::Schema.define(version: 2020_12_03_030841) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: :cascade do |t|
    t.text "content", null: false
    t.bigint "user_id", null: false
    t.bigint "description_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "parent_id"
    t.index ["description_id"], name: "index_comments_on_description_id"
    t.index ["parent_id"], name: "index_comments_on_parent_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "descriptions", force: :cascade do |t|
    t.text "content", null: false
    t.bigint "user_id", null: false
    t.bigint "term_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["term_id"], name: "index_descriptions_on_term_id"
    t.index ["user_id"], name: "index_descriptions_on_user_id"
  end

  create_table "genres", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "keeps", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "term_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["term_id"], name: "index_keeps_on_term_id"
    t.index ["user_id"], name: "index_keeps_on_user_id"
  end

  create_table "likes", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "description_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["description_id"], name: "index_likes_on_description_id"
    t.index ["user_id"], name: "index_likes_on_user_id"
  end

  create_table "taggings", force: :cascade do |t|
    t.bigint "term_id", null: false
    t.bigint "tag_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tag_id"], name: "index_taggings_on_tag_id"
    t.index ["term_id", "tag_id"], name: "index_taggings_on_term_id_and_tag_id", unique: true
    t.index ["term_id"], name: "index_taggings_on_term_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "genre_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["genre_id"], name: "index_tags_on_genre_id"
    t.index ["user_id"], name: "index_tags_on_user_id"
  end

  create_table "terms", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "user_id"
    t.bigint "genre_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["genre_id"], name: "index_terms_on_genre_id"
    t.index ["user_id"], name: "index_terms_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "profile", default: "", null: false
    t.boolean "admin", default: false, null: false
    t.string "image"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "comments", "comments", column: "parent_id"
  add_foreign_key "comments", "descriptions"
  add_foreign_key "comments", "users"
  add_foreign_key "descriptions", "terms"
  add_foreign_key "descriptions", "users"
  add_foreign_key "keeps", "terms"
  add_foreign_key "keeps", "users"
  add_foreign_key "likes", "descriptions"
  add_foreign_key "likes", "users"
  add_foreign_key "taggings", "tags"
  add_foreign_key "taggings", "terms"
  add_foreign_key "tags", "genres"
  add_foreign_key "tags", "users"
  add_foreign_key "terms", "genres"
  add_foreign_key "terms", "users"
end
