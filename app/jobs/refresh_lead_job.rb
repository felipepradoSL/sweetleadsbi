class RefreshLeadJob < ApplicationJob
  queue_as :default

  def perform()


  	conditions = []

  	begin

  		inicio = Date.yesterday
  		fim = Date.today
      conditions << "googleads.date BETWEEN '#{inicio.to_date.to_s(:db)}' AND '#{fim.to_date.to_s(:db)}'"

  		@leads = Googlead.where(conditions.join(' AND '))

  		if @leads.blank?
  			@erros = "Nenhum resultado"
  		else
  			@leads.each do |adword|
  				results = Hotmart.where("UPPER(unaccent(hotmarts.prod_name)) LIKE '%#{I18n.transliterate(adword.campaign_name.upcase)}%'").where(purchase_date: adword.date)
  				
  				status = []
  				results.distinct.pluck(:status).each do |s|
  					status << ["#{s}", results.where(status: s).size]
  				end
  				
  				payment_type = []
  				results.distinct.pluck(:payment_type).each do |s|
  					payment_type << ["#{s}", results.where(payment_type: s).size]
  				end
  				
  				original_offer_price = results.first&.original_offer_price
  				producer_name = results.first&.producer_name
  				src = results.first&.src
  				
  				
  				refusal_reason = {}
  				results.distinct.pluck(:refusal_reason).each do |s|
  					refusal_reason[s] = results.where(refusal_reason: s).size
  				end
  				
  				cms_aff = 0.0
  				results.each do |s|
  					cms_aff += s.cms_aff.to_f
  				end

  				@lead = Lead.find_by(date: adword.date, product: adword.campaign_name)

  				if @lead.present?
  					@lead.update(clicks: adword.clicks, impressions: adword.impressions, cost: adword.cost, 
	  					conversions: adword.conversions, conversions_value: adword.conversions_value, results: results.size, 
	  					status: status, payment_type: payment_type, cms_aff: cms_aff, src: src, original_offer_price: original_offer_price, 
	  					producer_name: producer_name, refusal_reason: refusal_reason)
  				else
  					@lead = Lead.create(date: adword.date, product: adword.campaign_name, clicks: adword.clicks, impressions: adword.impressions, cost: adword.cost, 
	  					conversions: adword.conversions, conversions_value: adword.conversions_value, results: results.size, 
	  					status: JSON.parse(status.to_json), payment_type: JSON.parse(payment_type.to_json), cms_aff: cms_aff, src: src, original_offer_price: original_offer_price, 
	  					producer_name: producer_name, refusal_reason: refusal_reason)
  				end


  			end
  		end



  		
  	rescue Exception => @erros


  		Rails.logger.debug("  ============== Exception:  #{@erros} ")

  	end



  end
end
