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

ActiveRecord::Schema[8.1].define(version: 2026_05_14_125634) do
  create_table "questions", force: :cascade do |t|
    t.string "answer"
    t.text "body"
    t.datetime "created_at", null: false
    t.integer "soup_question_id", null: false
    t.datetime "updated_at", null: false
    t.index ["soup_question_id"], name: "index_questions_on_soup_question_id"
  end

  create_table "soup_questions", force: :cascade do |t|
    t.text "answer"
    t.text "body"
    t.datetime "created_at", null: false
    t.text "explanation"
    t.string "title"
    t.datetime "updated_at", null: false
  end

  add_foreign_key "questions", "soup_questions"
end
