Rails.application.routes.draw do
  
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users, only: [] do
    resources :schedules do
    end
  end

  root 'main#first'
  
  match '/:controller(/:action(/:id))', via: [:get, :post]

end
