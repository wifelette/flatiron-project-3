Rails.application.routes.draw do
  resources :specs, only: [:show, :edit, :new, :create, :destroy]
  resources :events do 
    resources :packages
  end
  resources :perks
  
  # get '/events/:event_id/packages/:id/define', to:  "specs#define", as: "define"
end
