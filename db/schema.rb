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

ActiveRecord::Schema[8.1].define(version: 2026_02_15_082527) do
  create_table "authors", force: :cascade do |t|
    t.text "bio"
    t.datetime "created_at", null: false
    t.string "name"
    t.datetime "updated_at", null: false
  end

  create_table "book_shelves", force: :cascade do |t|
    t.integer "book_id", null: false
    t.datetime "created_at", null: false
    t.integer "shelf_id", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id"], name: "index_book_shelves_on_book_id"
    t.index ["shelf_id"], name: "index_book_shelves_on_shelf_id"
  end

  create_table "books", force: :cascade do |t|
    t.integer "author_id"
    t.string "cover_url"
    t.datetime "created_at", null: false
    t.text "description"
    t.string "isbn"
    t.integer "status"
    t.string "title"
    t.datetime "updated_at", null: false
    t.index ["author_id"], name: "index_books_on_author_id"
  end

  create_table "reading_sessions", force: :cascade do |t|
    t.integer "book_id", null: false
    t.datetime "created_at", null: false
    t.date "date"
    t.integer "duration_minutes"
    t.integer "pages_read"
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["book_id"], name: "index_reading_sessions_on_book_id"
    t.index ["user_id"], name: "index_reading_sessions_on_user_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.integer "book_id", null: false
    t.text "content"
    t.datetime "created_at", null: false
    t.integer "rating"
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["book_id"], name: "index_reviews_on_book_id"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "shelves", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name"
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["user_id"], name: "index_shelves_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email"
    t.string "name"
    t.string "password_digest"
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "book_shelves", "books"
  add_foreign_key "book_shelves", "shelves"
  add_foreign_key "books", "authors"
  add_foreign_key "reading_sessions", "books"
  add_foreign_key "reading_sessions", "users"
  add_foreign_key "reviews", "books"
  add_foreign_key "reviews", "users"
  add_foreign_key "shelves", "users"
end
