Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :wiki, only: %i[index show]
    end
  end

  root 'api/v1/wiki'
end
