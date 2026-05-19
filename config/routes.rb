Rails.application.routes.draw do
  root "soup_questions#index"

  resources :soup_questions do
    resources :questions, only: [:create]

    member do
      get :answer
      post :check_answer
    end
  end
end