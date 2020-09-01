class EduzzsController < ActionController::Base
	
	before_action :authenticate_user!
	protect_from_forgery with: :null_session
	skip_before_action :verify_authenticity_token, only: [:hotmart, :adwords, :bingads]
	layout 'application'


	def index
		conditions = []


		if params[:start].blank?
			params[:start] = (l Date.today.beginning_of_day, format: :default)
		end

		if params[:end].blank?
			params[:end] = (l Date.today.end_of_day, format: :default)
		end

  	conditions << "eduzzs.date_create BETWEEN '#{params[:start].to_date.to_s(:db)}' AND '#{params[:end].to_date.to_s(:db)}'"
		#conditions << "(UPPER(unaccent(eduzzs.produto)) LIKE '%#{I18n.transliterate(params[:produto].upcase)}%')" unless params[:produto].blank? 
		#conditions << "(UPPER(unaccent(eduzzs.sale_id)) LIKE '%#{I18n.transliterate(params[:transaction].upcase)}%')" unless params[:transaction].blank? 
		#conditions << "(UPPER(unaccent(eduzzs.hotmart_purchase_status)) LIKE 'COMPLETE' OR UPPER(unaccent(eduzzs.hotmart_purchase_status)) LIKE 'APPROVED')" 

		@eduzzs = Eduzz.where(conditions.join(" AND "))


	end

end
