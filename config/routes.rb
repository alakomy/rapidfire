Rapidfire::Engine.routes.draw do
  resources :surveys, param: :api_id do
    get 'results', on: :member

    resources :questions
    resources :attempts  
    
    
    
  end
  
 

  root :to => "surveys#index"
end
