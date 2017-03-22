Rails.application.routes.draw do
  resources :invitations do
    member do
      get :accept
    end
  end
end
