Rails.application.routes.draw do
  resources :events do 
    resources :packages
  end
  resources :perks
end
