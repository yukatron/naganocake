Rails.application.routes.draw do

	root 'public/items#top'
	get '/admin' => 'admin/homes#top', as: 'admin_top'

	scope module: :public do
		devise_for :customers, controllers: {
			registrations: 'public/registrations',
			sessions: 'public/sessions'
		}
		resources :addresses, only: [:index, :edit]
		get 'items/about' => 'items#about', as: 'about'
		resources :items, only: [:index, :show]
			get 'items/top' => 'items#top'
		resources :customers, only: [:show, :edit, :update]
			get 'customers/unsubscribe' => 'customers#unsubscribe', as: 'unsubscribe'
			patch 'customers/withdraw' => 'customers#withdraw', as: 'withdraw'
		resources :cart_items, only: [:index, :create, :update, :destroy] do
			collection do
				delete 'destroy_all'
			end
		end
		resources :orders, only: [:new, :index, :show, :create]
			post 'orders/confirm' => 'orders#confirm', as: 'order_confirm'
			get 'orders/thanks' => 'orders#thanks', as: 'thanks'
	end

	devise_for :admin, skip: :all
	devise_scope :admin do
		get 'admin/sign_in' => 'admin/sessions#new', as: :new_admin_session
		post 'admin/sign_in' => 'admin/sessions#create', as: :admin_session
		delete 'admin/sign_out' => 'admin/sessions#destroy', as: :destroy_admin_session
	end

	namespace :admin do
		resources :customers, only: [:index, :show, :edit, :update]
		resources :genres, only: [:index, :create, :edit, :update]
		resources :items, except: [:destroy] do
			resource :favorites, only: [:create, :destroy]
		end
		resources :orders, only: [:index, :show, :update]
		resources :order_details, only: [:update]
	end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
