Rails.application.routes.draw do


	scope module: :public do
		devise_for :customers, controllers: {
			registrations: 'public/registrations',
			sessions: 'public/sessions'
		}
		root 'items#top'
		resources :addresses, only: [:index, :edit]
		resources :items, only: [:index, :show]
			get 'items/top' => 'items#top'
			get 'items/about' => 'items#about', as: 'about'
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

	namespace :admin do
		devise_for :admin, controllers: {
			sessions: 'admin/sessions'
		}
		resources :customers, only: [:index, :show, :edit, :update]
		resources :genres, only: [:index, :create, :edit, :update]
		resources :items, except: [:destroy]
		get '/' => 'homes#top', as: 'admin_top'
		resources :orders, only: [:index, :show, :update]
		resources :order_details, only: [:update]
	end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
