json.extract! soup_question, :id, :title, :body, :answer, :explanation, :created_at, :updated_at
json.url soup_question_url(soup_question, format: :json)
