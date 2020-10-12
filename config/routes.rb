Rails.application.routes.draw do
  root to: "brokers#index"
  get 'brokers/import' => 'brokers#my_import'
  get 'brokers/map_data' => 'brokers#map_data'
  resources :brokers do
    collection {post :import}
    collection {post :map_data}
  end
end
