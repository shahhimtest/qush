Rails.application.routes.draw do
  root 'welcome#root'

  get 'signin' => 'users/sessions#new'
  delete 'signout' => 'users/sessions#destroy'

  get 'newsfeed' => 'newsfeed#show'

  get '@:username' => 'users#show', as: :user_short

  resources :relationships, only: [:create, :destroy]
  resources :messages, only: [:new, :create, :show, :destroy] do
    scope module: :messages do
      resources :likes, only: [:index]
      resource :like, only: [:create, :destroy]
    end
  end
  resources :users do
    get 'confirm/:confirmation_token' => 'users#confirm', as: :confirm

    scope module: :users do
      get 'follower' => 'relationships#follower'
      get 'following' => 'relationships#following'
    end

    collection do
      scope module: :users do
        resource :session, only: [:new, :create, :destroy]
      end
    end
  end
end
