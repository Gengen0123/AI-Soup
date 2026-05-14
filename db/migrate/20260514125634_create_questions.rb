class CreateQuestions < ActiveRecord::Migration[8.1]
  def change
    create_table :questions do |t|
      t.references :soup_question, null: false, foreign_key: true
      t.text :body
      t.string :answer

      t.timestamps
    end
  end
end
