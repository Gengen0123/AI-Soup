class AddUserToSoupQuestions < ActiveRecord::Migration[8.1]
  def change
    add_reference :soup_questions, :user, null: false, foreign_key: true
  end
end
