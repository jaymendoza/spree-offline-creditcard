Spree::Core::Engine.routes.draw do
	namespace :admin do
		resources :orders do
  		resources :credit_card_payments
  	end
  end
end