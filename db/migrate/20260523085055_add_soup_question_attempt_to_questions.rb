class AddSoupQuestionAttemptToQuestions < ActiveRecord::Migration[8.1]
  def change
    add_reference :questions, :soup_question_attempt, null: true, foreign_key: true
  end
end