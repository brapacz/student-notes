Rails.application.routes.draw do
  devise_for :users
  resources :visitors
  resources :students do
    get :subjects
  end
  resources :teachers do
    get :subjects
  end

  resources :report_subjects

  root to: 'visitors#index'
end
