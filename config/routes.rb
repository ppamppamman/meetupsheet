Rails.application.routes.draw do
  
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users, only: [] do
    resources :schedules do
    end
  end

  resources :group, only: [] do
    get '/notes/list', to: 'group#notes_list'
    post '/notes/create', to: 'group#note_create'
    resources :notes, only: [] do
      get 'show', to: 'group#show_editor'
      put 'update', to: 'group#note_update'
    end
    namespace :notes do
      get 'new_editor', to: '/group#new_editor'
    end
  end

  root 'main#first'
  
  match '/:controller(/:action(/:id))', via: [:get, :post]

end
