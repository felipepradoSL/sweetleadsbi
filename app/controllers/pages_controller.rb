class PagesController < ActionController::Base
	require 'json'
	layout 'application'
	before_action :authenticate_user!, only: [:home, :leads_hotmart, :leads_adwords ]
	protect_from_forgery with: :null_session
	skip_before_action :verify_authenticity_token, only: [:hotmart, :adwords, :bingads]


  def home
  end

  def get_token
		Setting.token_one              			    = params[:token_one] unless params[:token_one].blank?
		Setting.token_two              			    = params[:token_two] unless params[:token_two].blank?

		redirect_to request.referrer, notice: "Atualizado!"
  end

  def att_hotmart_async
  	UpdateHotmartAsyncJob.perform_later(Setting.token_one)
  	UpdateHotmartAsyncJob.perform_later(Setting.token_two)
    respond_to do |format|
    	format.js {render inline: "M.toast({html: 'Estamos processando sua requisição, isto pode demorar uns minutos', classes: 'green'}); " }
    end
  end

  def att_hotmart
  	UpdateHotmartJob.perform_later(hotmart_params) unless params[:data].blank?
  end

  def retro_hotmart
  	conditions = []
  	if params[:retro_hotmart] == "true"

  		conditions = []
  		conditions << "to_date(retro_hotmarts.purchase_approveddate, 'YY MM DD') BETWEEN '#{session[:start].to_date.to_s(:db)}' AND '#{session[:end].to_date.to_s(:db)}'" unless session[:start].blank? or session[:end].blank?


  		@leads = RetroHotmart.where(conditions.join(' AND ')).order("purchase_approveddate desc")
  	else

  		begin

  			if params[:start].blank?
  				params[:start] = (l Date.yesterday, format: :default)
  			end

  			if params[:end].blank?
  				params[:end] = (l Date.today, format: :default)
  			end

  			session[:start] = params[:start]
  			session[:end] = params[:end]

  			conditions << "to_date(retro_hotmarts.purchase_approveddate, 'YY MM DD') BETWEEN '#{params[:start].to_date.to_s(:db)}' AND '#{params[:end].to_date.to_s(:db)}'"

  			@leads = RetroHotmart.where(conditions.join(' AND ')).order("purchase_approveddate desc")

  			if @leads.blank?
  				@erros = "Nenhum resultado"
  			end


  		rescue Exception => @erros

  		end

  	end

    respond_to do |format|
    	format.js
    	format.html
      format.xlsx {
        response.headers["Content-Disposition"] = "attachment; filename=Hotmart.xlsx"
      }
    end
  end
  
  def leads_hotmart
  	@leads = Hotmart.all

    respond_to do |format|
    	format.js
    	format.html
      format.xlsx {
        response.headers["Content-Disposition"] = "attachment; filename=Hotmart.xlsx"
      }
    end
  end
  
  def leads_adwords
  	conditions = []
  	if params[:adwords] == "true"

  		conditions = []
  		conditions << "googleads.date BETWEEN '#{session[:start].to_date.to_s(:db)}' AND '#{session[:end].to_date.to_s(:db)}'" unless session[:start].blank? or session[:end].blank?


  		@adwords = Googlead.where(conditions.join(' AND '))
  	else

  		begin

  			if params[:start].blank?
  				params[:start] = (l Date.yesterday, format: :default)
  			end

  			if params[:end].blank?
  				params[:end] = (l Date.today, format: :default)
  			end

  			session[:start] = params[:start]
  			session[:end] = params[:end]

  			conditions << "googleads.date BETWEEN '#{params[:start].to_date.to_s(:db)}' AND '#{params[:end].to_date.to_s(:db)}'"

  			@leads = Googlead.where(conditions.join(' AND '))

  			if @leads.blank?
  				@erros = "Nenhum resultado"
  			end


  		rescue Exception => @erros

  		end

  	end
  	respond_to do |format|
  		format.js
  		format.html
  		format.xlsx {
  			response.headers["Content-Disposition"] = "attachment; filename=Adwords.xlsx"
  		}
  	end

  end
  
  def leads_bing
  	conditions = []
  	if params[:bing] == "true"

  		conditions = []
  		conditions << "bings.date BETWEEN '#{session[:start].to_date.to_s(:db)}' AND '#{session[:end].to_date.to_s(:db)}'" unless session[:start].blank? or session[:end].blank?


  		@bings = Bing.where(conditions.join(' AND '))
  	else

  		begin

  			if params[:start].blank?
  				params[:start] = (l Date.yesterday, format: :default)
  			end

  			if params[:end].blank?
  				params[:end] = (l Date.today, format: :default)
  			end

  			session[:start] = params[:start]
  			session[:end] = params[:end]

  			conditions << "bings.date BETWEEN '#{params[:start].to_date.to_s(:db)}' AND '#{params[:end].to_date.to_s(:db)}'"

  			@leads = Bing.where(conditions.join(' AND '))

  			if @leads.blank?
  				@erros = "Nenhum resultado"
  			end


  		rescue Exception => @erros

  		end

  	end
  	respond_to do |format|
  		format.js
  		format.html
  		format.xlsx {
  			response.headers["Content-Disposition"] = "attachment; filename=Bing.xlsx"
  		}
  	end

  end

  def bingads
  	if params[:token] == '4N69eOXEQ4'
  		data = JSON.parse(params[:data])
  		UpdateBingJob.perform_later(data)
  	end
  end

  #{"ExternalCustomerId":"7105592252","Date":"2019-06-19","CampaignName":"Teste CPC Otimizado","AccountDescriptiveName":"Marize 2","Clicks":1,"Impressions":12,"Cost":3.51,"Conversions":0,"ConversionValue":0}
  def adwords
  	if params[:token] == '4N69eOXEQ4'
  		data = JSON.parse(params[:data])
  		data.each do |row|
  			@googlead = Googlead.find_by(customer_id: row["ExternalCustomerId"], date: row["Date"], campaign_id: row["CampaignId"])
				if @googlead.present?	
					@googlead.campaign_name                                = row["CampaignName"].to_s.split('] ').last
					@googlead.clicks                                       = row["Clicks"]
					@googlead.impressions                                  = row["Impressions"]
					@googlead.cost                                         = row["Cost"].to_f
					@googlead.conversions                                  = row["Conversions"]
					@googlead.conversions_value                            = row["ConversionValue"].to_f
					@googlead.account_description_name                     = row["AccountDescriptiveName"]
					@googlead.save
					sleep 0.1
					Rails.logger.debug("  ============== Atualizado:  #{@googlead.attributes} ")
  			else
  				@googlead = Googlead.new
					@googlead.customer_id 																	= row["ExternalCustomerId"]
					@googlead.date 																				= row["Date"]
					@googlead.campaign_name                                = row["CampaignName"].to_s.split('] ').last
					@googlead.campaign_id                                	= row["CampaignId"]
					@googlead.account_description_name                     = row["AccountDescriptiveName"]
					@googlead.clicks                                       = row["Clicks"]
					@googlead.impressions                                  = row["Impressions"]
					@googlead.cost                                         = row["Cost"].to_f
					@googlead.conversions                                  = row["Conversions"]
					@googlead.conversions_value                            = row["ConversionValue"].to_f
					@googlead.save
					sleep 0.1
					Rails.logger.debug("  ============== Cadastrado:  #{@googlead.attributes} ")
  			end
  		end
  	end
  end

  def hotmart
  	if params[:hottok] == "U4hPf4yctVTyHX9ddNELS3dMhFlHY25bc56b1d-8022-4054-bfc9-46863bb6d999" or params[:hottok] == "6ttoKa21jQvWBYC12ghNp1kLhmB94q2123620"
			
  		@hotmart = Hotmart.find_by(transactionn: params[:transaction])
  		if @hotmart.present?
				@hotmart.prod = params[:prod]
				@hotmart.prod_name = params[:prod_name]
				@hotmart.off = params[:off]
				@hotmart.price = params[:price]
				@hotmart.aff = params[:aff]
				@hotmart.aff_name = params[:aff_name]
				@hotmart.email = params[:email]
				@hotmart.name = params[:name]
				@hotmart.first_name = params[:first_name]
				@hotmart.last_name = params[:last_name]
				@hotmart.doc = params[:doc]
				@hotmart.phone_local_code = params[:phone_local_code]
				@hotmart.phone_number = params[:phone_number]
				@hotmart.phone_checkout_local_code = params[:phone_checkout_local_code]
				@hotmart.phone_checkout_number = params[:phone_checkout_number]
				@hotmart.address = params[:address]
				@hotmart.address_number = params[:address_number]
				@hotmart.address_country = params[:address_country]
				@hotmart.address_district = params[:address_district]
				@hotmart.address_comp = params[:address_comp]
				@hotmart.address_city = params[:address_city]
				@hotmart.address_state = params[:address_state]
				@hotmart.address_zip_code = params[:address_zip_code]
				@hotmart.xcod = params[:xcod]
				@hotmart.src = params[:src]
				@hotmart.status = params[:status]
				@hotmart.payment_engine = params[:payment_engine]
				@hotmart.payment_type = params[:payment_type]
				@hotmart.hotkey = params[:hotkey]
				@hotmart.name_subscription_plan = params[:name_subscription_plan]
				@hotmart.subscriber_code = params[:subscriber_code]
				@hotmart.recurrency_period = params[:recurrency_period]
				@hotmart.recurrency = params[:recurrency]
				@hotmart.cms_marketplace = params[:cms_marketplace]
				@hotmart.cms_vendor = params[:cms_vendor]
				@hotmart.cms_aff = params[:cms_aff].to_f
				@hotmart.coupon_code = params[:coupon_code]
				@hotmart.callback_type = params[:callback_type]
				@hotmart.subscription_status = params[:subscription_status]
				@hotmart.transaction_ext = params[:transaction_ext]
				@hotmart.sck = params[:sck]
				@hotmart.purchase_date = params[:purchase_date].to_date
				@hotmart.confirmation_purchase_date = params[:confirmation_purchase_date]
				@hotmart.billet_url = params[:billet_url]
				@hotmart.currency_code_from = params[:currency_code_from]
				@hotmart.original_offer_price = params[:original_offer_price].to_f
				@hotmart.currency = params[:currency]
				@hotmart.billet_barcode = params[:billet_barcode]
				@hotmart.producer_name = params[:producer_name]
				@hotmart.producer_document = params[:producer_document]
				@hotmart.producer_legal_nature = params[:producer_legal_nature]
				@hotmart.currency_code_from_ = params[:currency_code_from_]
				@hotmart.refusal_reason = params[:refusal_reason]
				@hotmart.doc_type = params[:doc_type]
				@hotmart.full_price = params[:full_price]
				@hotmart.warranty_date = params[:warranty_date]
				@hotmart.cms_aff_currency = params[:cms_aff_currency]
				@hotmart.product_support_email = params[:product_support_email]
				@hotmart.amount = params[:amount]
				@hotmart.affiliate = params[:affiliate]
				@hotmart.productName = params[:productName]
				@hotmart.productUcode = params[:productUcode]
				@hotmart.productCategory = params[:productCategory]
				@hotmart.buyerVO = params[:buyerVO]
  		else
  			@hotmart = Hotmart.new()
				@hotmart.prod = params[:prod]
				@hotmart.prod_name = params[:prod_name]
				@hotmart.off = params[:off]
				@hotmart.price = params[:price]
				@hotmart.aff = params[:aff]
				@hotmart.aff_name = params[:aff_name]
				@hotmart.email = params[:email]
				@hotmart.name = params[:name]
				@hotmart.first_name = params[:first_name]
				@hotmart.last_name = params[:last_name]
				@hotmart.doc = params[:doc]
				@hotmart.phone_local_code = params[:phone_local_code]
				@hotmart.phone_number = params[:phone_number]
				@hotmart.phone_checkout_local_code = params[:phone_checkout_local_code]
				@hotmart.phone_checkout_number = params[:phone_checkout_number]
				@hotmart.address = params[:address]
				@hotmart.address_number = params[:address_number]
				@hotmart.address_country = params[:address_country]
				@hotmart.address_district = params[:address_district]
				@hotmart.address_comp = params[:address_comp]
				@hotmart.address_city = params[:address_city]
				@hotmart.address_state = params[:address_state]
				@hotmart.address_zip_code = params[:address_zip_code]
				@hotmart.transactionn = params[:transaction]
				@hotmart.xcod = params[:xcod]
				@hotmart.src = params[:src]
				@hotmart.status = params[:status]
				@hotmart.payment_engine = params[:payment_engine]
				@hotmart.payment_type = params[:payment_type]
				@hotmart.hotkey = params[:hotkey]
				@hotmart.name_subscription_plan = params[:name_subscription_plan]
				@hotmart.subscriber_code = params[:subscriber_code]
				@hotmart.recurrency_period = params[:recurrency_period]
				@hotmart.recurrency = params[:recurrency]
				@hotmart.cms_marketplace = params[:cms_marketplace]
				@hotmart.cms_vendor = params[:cms_vendor]
				@hotmart.cms_aff = params[:cms_aff].to_f
				@hotmart.coupon_code = params[:coupon_code]
				@hotmart.callback_type = params[:callback_type]
				@hotmart.subscription_status = params[:subscription_status]
				@hotmart.transaction_ext = params[:transaction_ext]
				@hotmart.sck = params[:sck]
				@hotmart.purchase_date = params[:purchase_date].to_date
				@hotmart.confirmation_purchase_date = params[:confirmation_purchase_date]
				@hotmart.billet_url = params[:billet_url]
				@hotmart.currency_code_from = params[:currency_code_from]
				@hotmart.original_offer_price = params[:original_offer_price].to_f
				@hotmart.currency = params[:currency]
				@hotmart.billet_barcode = params[:billet_barcode]
				@hotmart.producer_name = params[:producer_name]
				@hotmart.producer_document = params[:producer_document]
				@hotmart.producer_legal_nature = params[:producer_legal_nature]
				@hotmart.currency_code_from_ = params[:currency_code_from_]
				@hotmart.refusal_reason = params[:refusal_reason]
				@hotmart.doc_type = params[:doc_type]
				@hotmart.full_price = params[:full_price]
				@hotmart.warranty_date = params[:warranty_date]
				@hotmart.cms_aff_currency = params[:cms_aff_currency]
				@hotmart.product_support_email = params[:product_support_email]
				@hotmart.amount = params[:amount]
				@hotmart.affiliate = params[:affiliate]
				@hotmart.productName = params[:productName]
				@hotmart.productUcode = params[:productUcode]
				@hotmart.productCategory = params[:productCategory]
				@hotmart.buyerVO = params[:buyerVO]
  		end

			@hotmart.save
  	end
		respond_to do |format|
			format.js
			format.html
			format.json
		end
  end

  private 
    def hotmart_params
			params.require(:data).permit(:data => {})
    end

end
