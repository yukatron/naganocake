Rails.application.routes.draw do

	scope module: :public do
	  devise_for :customers, controllers: {
	  	registrations: 'public/registrations',
	  	sessions: 'public/sessions'
	  }
	  root 'public/items#top'
	  get 'items/about' => 'public/items"about', as: 'about'
	end


	devise_scope :admin do
	  	devise_for :admins, path: 'admin', controllers: {
	  		sessions: 'admins/sessions'
	  	}
	end

	namespace :admin do
		get '/admin' => 'admin#top', as: 'top'
	end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
