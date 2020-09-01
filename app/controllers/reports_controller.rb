class ReportsController < ActionController::Base
	
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

  	conditions << "to_date(reports.date, 'YY MM DD') BETWEEN '#{params[:start].to_date.to_s(:db)}' AND '#{params[:end].to_date.to_s(:db)}'"
		conditions << "(UPPER(unaccent(reports.produto)) LIKE '%#{I18n.transliterate(params[:produto].upcase)}%')" unless params[:produto].blank? 
		conditions << "(UPPER(unaccent(reports.hotmart_purchase_transaction)) LIKE '%#{I18n.transliterate(params[:transaction].upcase)}%')" unless params[:transaction].blank? 
		#conditions << "(UPPER(unaccent(reports.hotmart_purchase_status)) LIKE 'COMPLETE' OR UPPER(unaccent(reports.hotmart_purchase_status)) LIKE 'APPROVED')" 

		@reports = Report.where(conditions.join(" AND "))


	end

end
