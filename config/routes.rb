Rails.application.routes.draw do
  root 'welcome#index'
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }

  scope module: 'users' do
    resources :synchronizations, only: :index, as: :synchronizations
  end

  scope module: 'google' do
    resources :calendars, only: :index
  end

  post '/integrate' => 'slack_users#create'
end
