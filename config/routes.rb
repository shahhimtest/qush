Rails.application.routes.draw do
  root 'welcome#root'

  get 'signin' => 'users/sessions#new'
  delete 'signout' => 'users/sessions#destroy'

  get 'newsfeed' => 'newsfeed#show'

  resources :relationships, only: [:create, :destroy]
  resources :messages, only: [:new, :create, :show, :destroy]
  resources :users do
    get 'confirm/:confirmation_token' => 'users#confirm', as: :confirm

    collection do
      scope module: :users do
        resource :session, only: [:new, :create, :destroy]
      end
    end
  end
end
