Rails.application.routes.draw do
  root "soup_questions#index"

  get "/auth/:provider/callback", to: "sessions#create"
  get "/auth/failure", to: redirect("/")
  delete "/logout", to: "sessions#destroy"

  get "/my/soup_questions", to: "soup_questions#mine", as: :my_soup_questions
  
  resources :soup_questions do
    resources :questions, only: [:create]

    member do
      get :answer
      post :check_answer
    end
  end
end