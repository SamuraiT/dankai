Rails.application.routes.draw do
  post 'user_token' => 'user_token#create'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users, only: [:show, :create], shallow: true do
    resource :icon, only: :show
    member do
      get 'followings'
      get 'followers'
      post 'follow'
      post 'unfollow'
    end
  end
  resources :posts, only: [:index, :show, :create], shallow: true do
    resource :image, only: [:show, :create]
    resources :likes, only: :create
    resources :comments, only: :create
  end
  resources :latest_posts, only: [:index]

  get '/initialize', to: 'initialize#do'
end
