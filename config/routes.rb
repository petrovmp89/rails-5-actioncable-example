Rails.application.routes.draw do
  root 'news#index'
  get '/news' => 'news#index'
  get '/admin' => 'news#new'
  post '/news' => 'news#create'
end
