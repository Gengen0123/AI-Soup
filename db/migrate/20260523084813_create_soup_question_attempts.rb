class CreateSoupQuestionAttempts < ActiveRecord::Migration[8.1]
  def change
    create_table :soup_question_attempts do |t|
      t.references :soup_question, null: false, foreign_key: true
      t.references :user, null: true, foreign_key: true
      t.string :session_token, null: false
      t.boolean :solved, null: false, default: false
      t.boolean :gave_up, null: false, default: false

      t.timestamps
    end

    add_index :soup_question_attempts, [:soup_question_id, :session_token], unique: true, name: "index_attempts_on_question_and_session"
  end
end