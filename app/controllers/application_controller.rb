class ApplicationController < ActionController::Base
	before_action :authenticate_user!
	protect_from_forgery with: :exception
	before_action :store_user_location!, if: :storable_location?
	rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
	

	rescue_from CanCan::AccessDenied do |exception|
		flash[:alert] = "Você não tem permissão para acessar!"
		redirect_back(fallback_location: root_url)
	end

	private


	def record_not_found
		flash[:alert] = "Você está tentando acessar algo que não existe."
		redirect_back(fallback_location: root_url)
	end

	def storable_location?
		request.get? && is_navigational_format? && !devise_controller? && !request.xhr? 
	end

	def store_user_location!
	  # :user is the scope we are authenticating
	  store_location_for(:user, request.fullpath)
	end

  def after_sign_out_path_for(resource_or_scope)
  	stored_location_for(resource_or_scope) || super
  end
end
