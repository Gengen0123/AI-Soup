Rails.application.routes.draw do
  root "soup_questions#index"

  resources :soup_questions do
    resources :questions, only: [:create]
  end
end