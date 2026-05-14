class CreateSoupQuestions < ActiveRecord::Migration[8.1]
  def change
    create_table :soup_questions do |t|
      t.string :title
      t.text :body
      t.text :answer
      t.text :explanation

      t.timestamps
    end
  end
end
