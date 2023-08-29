Rails.application.routes.draw do
  namespace :api do
    get 'tokens/create'
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :api, defaults: { format: :json } do
    resources :admins, only: %i[create show update destroy]
    resources :tokens, only: [:create]
    resources :traders, only: %i[index show create update destroy]
    resources :trader_tokens, only: %i[create]
    resources :tickers, only: %i[index create show update destroy]
    resources :transactions, only: %i[index show create destroy]
    resources :ticker_tokens, only: %i[create]
  end
end
