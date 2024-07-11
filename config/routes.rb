# == Route Map
#

Rails.application.routes.draw do

  root 'tests#index'

  devise_for :users, path: :gurus, path_names: { sign_in: :login, sign_out: :logout }

  get 'admin/tests', to: 'tests#index', as: 'admin_tests'


  resources :tests do
    resources :questions, shallow: true do
      resources :answers, shallow: true
    end

    member do
      post :start
    end
  end

  resources :categories

  # GET /test_passages/101/result
  resources :test_passages, only: %i[show update] do
    member do
      get :result
    end
  end
end
