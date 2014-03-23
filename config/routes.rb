SmellyCode::Application.routes.draw do

  # Routes for static pages
  root "snippets#index"
  get '/faq' => 'pages#faq'

  # Resourceful routes

  resources :snippets, except: [:destroy] do
    post 'highlight_code' => 'snippets#highlight_code', on: :collection
  end
  resources :users, only: [:show]

  # Devise routes for users
  devise_for :users,
      controllers: {
          registrations: 'users/registrations',
          sessions: 'users/sessions',
          passwords: 'users/passwords'
      }, path: ''

  devise_scope :user do
    get "/settings" => "users/registrations#edit"
    post '/credentials_already_taken' => 'users/registrations#credentials_already_taken?'
  end

  # Devise routes for admins

  devise_for :admins

  # Admin routes
  namespace :admin do

  end

end
