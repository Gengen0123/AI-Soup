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

ActiveRecord::Schema[8.1].define(version: 2026_05_23_144703) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "questions", force: :cascade do |t|
    t.string "answer"
    t.text "body"
    t.datetime "created_at", null: false
    t.bigint "soup_question_attempt_id"
    t.integer "soup_question_id", null: false
    t.datetime "updated_at", null: false
    t.index ["soup_question_attempt_id"], name: "index_questions_on_soup_question_attempt_id"
    t.index ["soup_question_id"], name: "index_questions_on_soup_question_id"
  end

  create_table "soup_question_attempts", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.boolean "gave_up", default: false, null: false
    t.string "session_token", null: false
    t.boolean "solved", default: false, null: false
    t.bigint "soup_question_id", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["soup_question_id", "session_token"], name: "index_attempts_on_question_and_session", unique: true
    t.index ["soup_question_id"], name: "index_soup_question_attempts_on_soup_question_id"
    t.index ["user_id"], name: "index_soup_question_attempts_on_user_id"
  end

  create_table "soup_question_ratings", force: :cascade do |t|
    t.integer "clarity_score", null: false
    t.datetime "created_at", null: false
    t.integer "difficulty_score", null: false
    t.bigint "soup_question_id", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["soup_question_id", "user_id"], name: "index_ratings_on_question_and_user", unique: true
    t.index ["soup_question_id"], name: "index_soup_question_ratings_on_soup_question_id"
    t.index ["user_id"], name: "index_soup_question_ratings_on_user_id"
  end

  create_table "soup_questions", force: :cascade do |t|
    t.text "answer"
    t.text "body"
    t.datetime "created_at", null: false
    t.text "explanation"
    t.string "title"
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_soup_questions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email"
    t.string "image_url"
    t.string "name"
    t.string "provider"
    t.string "uid"
    t.datetime "updated_at", null: false
  end

  add_foreign_key "questions", "soup_question_attempts"
  add_foreign_key "questions", "soup_questions"
  add_foreign_key "soup_question_attempts", "soup_questions"
  add_foreign_key "soup_question_attempts", "users"
  add_foreign_key "soup_question_ratings", "soup_questions"
  add_foreign_key "soup_question_ratings", "users"
  add_foreign_key "soup_questions", "users"
end
