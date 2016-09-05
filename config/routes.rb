Rails.application.routes.draw do
  devise_for :users
  resources :visitors
  resources :students do
    get :subjects
  end
  resources :teachers do
    get :subjects
  end

  get 'report_subjects', action: 'subjects', controller: 'reports'

  resources :report do
    get :subjects
  end

  root to: 'visitors#index'
end
