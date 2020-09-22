Rails.application.routes.draw do

	scope module: :public do
	  devise_for :customers, controllers: {
	  	registrations: 'public/registrations',
	  	sessions: 'public/sessions'
	  }
	  root 'public/items#top'
	end

	devise_scope :admin do
	  devise_for :admins, controllers: {
	  	sessions: 'admin/sessions'
	  }
	end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
