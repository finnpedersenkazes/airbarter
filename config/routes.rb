Rails.application.routes.draw do
  mount Attachinary::Engine => "/attachinary"

  scope '(:locale)', locale: /en|ja|da|ar|fr/ do
    resources :transactions do
      member do
        patch :change_status
        patch :accept
      end
    end
    resources :entries
    resources :products #, only:[:index, :new, :create, :show]
    root to: 'pages#home'

    # Finn: I added this code back in
    devise_for :users, skip: :omniauth_callbacks

    get 'users/:id',   to: 'pages#profile' ,as: 'user_show'
  end

  # this is to handle facebook login without language

  # Finn: I added this code back in. See above.
  devise_for :users, only: :omniauth_callbacks,
    controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  # Finn: I removed this code.
  # devise_for :users,
  #   controllers: {
  #     omniauth_callbacks: 'users/omniauth_callbacks',
  #     confirmations: 'users/confirmations',
  #     passwords: 'users/passwords',
  #     sessions: 'users/sessions',
  #     unlocks: 'users/unlocks',
  #     registrations: "users/registrations"
  #   }

  # to avoide user from showing the profile page.
  # resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
