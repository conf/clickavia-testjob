ClickaviaTestJob::Application.routes.draw do
  root 'flights#index'

  resources :flights, only: [:index]
  namespace :parsers do
    resources :flights, only: [:index]
  end
end
