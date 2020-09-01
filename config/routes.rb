Rails.application.routes.draw do

	devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: "register"}

	controller :pages do
		get '/home' => :home
		post '/hotmart' => :hotmart
		post '/adwords' => :adwords
		post '/bingads' => :bingads
		get '/leads_hotmart' => :leads_hotmart
		get '/retro_hotmart' => :retro_hotmart
		get '/leads_adwords' => :leads_adwords
		get '/leads_bing' => :leads_bing
		post '/get_token' => :get_token
		post '/att_hotmart' => :att_hotmart
		post '/att_hotmart_async' => :att_hotmart_async
	end

    controller :reports do
    end
    resources :reports

    controller :eduzzs do
    end
    resources :eduzzs

	root "pages#home"  
	get '*path' => redirect('/')

end