class CreateSoupQuestionRatings < ActiveRecord::Migration[8.1]
  def change
    create_table :soup_question_ratings do |t|
      t.references :soup_question, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.integer :clarity_score, null: false
      t.integer :difficulty_score, null: false

      t.timestamps
    end

    add_index :soup_question_ratings, [:soup_question_id, :user_id], unique: true, name: "index_ratings_on_question_and_user"
  end
end