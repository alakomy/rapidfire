Rapidfire::Engine.routes.draw do
  resources :surveys do
    get 'results', on: :member

    resources :questions
    
    
    
    
  end
  
  scope '/surveys' do
    
    match '/:api_id/attempts(.:format)' => 'rapidfire/attempts#create', via: [:post], as: :survey_attempts
    match '/:api_id/attempts/new(.:format)' => 'rapidfire/attempts#new', via: [:get], as: :new_survey_attempt
    match '/:api_id/attempts/:id/edit(.:format)' => 'rapidfire/attempts#edit', via: [:get], as: :edit_survey_attempt
    match 'survey_attempt' => 'rapidfire/attempts#show', via: [:get], as: :survey_attempt
    
  end

  root :to => "surveys#index"
end
