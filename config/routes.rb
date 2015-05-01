Rails.application.routes.draw do
  devise_for :users
  resource :calendar, :only => [:show] do
    collection do
      get 'show_event'
      post 'create_guest'
      post 'show_edit'
      post 'update_event'
      post 'show_create'
      post 'create_event'
    end
  end
  resources :events do
    collection do
      get 'third_party'
      post 'third_party'
      post 'pull_third_party'
    end
  end
  resource :guests, :only => [:create]
  resources :accounts
  get '/', to: redirect('/calendar')
end
