Rails.application.routes.draw do
  get 'birdie/rest/topics', to: 'topics#index'
  post 'birdie/rest/topic', to: 'topics#create'
  post 'birdie/rest/topics/load', to: 'topics#load'
  delete 'birdie/rest/topic', to: 'topics#destroy'
end