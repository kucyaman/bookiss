Rails.application.routes.draw do
  root "home#top"

  resources :books, only: %i[index new create] do
    resources :pages, only: %i[new create]
  end

  post '/user_sessions/callback', to: 'user_sessions#callback'
  delete 'logout', to: 'user_sessions#destroy', as: :logout
end
