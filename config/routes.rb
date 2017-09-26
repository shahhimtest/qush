Rails.application.routes.draw do
  root 'welcome#root'

  get 'signin' => 'users/sessions#new'
  delete 'signout' => 'users/sessions#destroy'

  resources :users do
    collection do
      scope module: :users do
        resource :session, only: [:new, :create, :destroy]
      end
    end
  end
end
