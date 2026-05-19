Rails.application.routes.draw do
  root "soup_questions#index"

  get "/auth/:provider/callback", to: "sessions#create"
  get "/auth/failure", to: redirect("/")
  delete "/logout", to: "sessions#destroy"

  resources :soup_questions do
    resources :questions, only: [:create]

    member do
      get :answer
      post :check_answer
    end
  end
end