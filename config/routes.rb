Rails.application.routes.draw do
  root to: "brokers#index"
  get 'brokers/import' => 'brokers#my_import'
  resources :brokers do
    collection {post :import}
  end
end
