WillPaginateExample::Application.routes.draw do
  resources :questions, only: [:index]
  root to: "static#home"
end