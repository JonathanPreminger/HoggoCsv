Rails.application.routes.draw do
  root to: "brokers#index"
  get 'brokers/import' => 'brokers#my_import'
  resources :brokers do
    collection {post :import}
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
