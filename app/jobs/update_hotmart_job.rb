class UpdateHotmartJob < ApplicationJob
  queue_as :default

  def perform(data)
  	
  	vetor = data.first.last

  	vetor.each do |key, val|
			retro = RetroHotmart.find_by(purchase_transaction: val["purchase"]["transaction"])

			if retro.blank?
				retro = RetroHotmart.new
			end
				retro.product_id = val["product"]["id"].to_i
				retro.product_name = val["product"]["name"]
				retro.product_ucode = val["product"]["uncode"]
				retro.product_hascoproduction = val["product"]["hasCoProduction"]
				retro.product_subscription = val["product"]["subscription"]
				retro.enotas_status = val["enotas"]["status"]
				retro.affiliate_id = val["affiliate"]["id"].to_i
				retro.affiliate_name = val["affiliate"]["name"]
				retro.affiliate_email = val["affiliate"]["email"]
				retro.affiliate_ucode = val["affiliate"]["ucode"]
				retro.affiliate_locale = val["affiliate"]["locale"]
				retro.commission_value = val["commission"]["value"].to_f
				retro.commission_currencycode = val["commission"]["currencyCode"]
				retro.purchase_transaction = val["purchase"]["transaction"]


				purchase_orderdate = Time.at((val["purchase"]["orderDate"].to_i / 1000))
				retro.purchase_orderdate = (purchase_orderdate.to_datetime)

				purchase_approveddate = Time.at((val["purchase"]["approvedDate"].to_i / 1000))
				retro.purchase_approveddate = (purchase_approveddate.to_datetime)

				retro.purchase_paymentengine = val["purchase"]["paymentEngine"]
				retro.purchase_status = val["purchase"]["status"]
				retro.purchase_price = val["purchase"]["price"]["value"].to_f
				retro.purchase_currencycode = val["purchase"]["price"]["currencyCode"]
				retro.purchase_paymenttype = val["purchase"]["paymentType"]
				retro.purchase_paymentmethod = val["purchase"]["paymentMethod"]
				retro.purchase_recurrencynumber = val["purchase"]["recurrencyNumber"].to_i
				retro.purchase_warrantyrefund = val["purchase"]["warrantyRefund"].to_i
				retro.purchase_salesnature = val["purchase"]["salesNature"]
				retro.purchase_source = val["purchase"]["source"]
				retro.purchase_underwarranty = val["purchase"]["underWarranty"]
				retro.purchase_subscription = val["purchase"]["purchaseSubscription"]
				retro.purchase_installmentsnumber = val["purchase"]["installmentsNumber"].to_i

				retro.offer_paymentmode = val["offer"]["paymentMode"].to_i
				retro.offer_key = val["offer"]["key"].to_i
				
				retro.save

  	end

  end
end


=begin
	
"3086"=>{
	"product"=>{"id"=>"81426", "name"=>"Curso de Violão Online - Você Pode Tocar", "ucode"=>"c8ee7ba1-541d-46d8-a0c9-7a84f3d52852", "hasCoProduction"=>"false", "subscription"=>"false"}, 
"enotas"=>{"status"=>"NOT_AVAILABLE"}, 
"affiliate"=>{"id"=>"6928941", "name"=>"Leonardo Colmanetti Correa", "email"=>"", "ucode"=>"5bc56b1d-8022-4054-bfc9-46863bb6d999", "locale"=>"EN", 
	"documents"=>{
	"0"=>{"value"=>"30228298000152", "type"=>"CNPJ"}}}, 
"commission"=>{"value"=>"136.86", "currencyCode"=>"BRL"}, 
"purchase"=>{"transaction"=>"HP15815475616878", "orderDate"=>"1547561688000", "approvedDate"=>"1547561690000", "paymentEngine"=>"hotmart", "status"=>"COMPLETE", 
	"price"=>{"value"=>"297", "currencyCode"=>"BRL"}, "paymentType"=>"CartaoDeCredito", "paymentMethod"=>"CARTAO_CREDITO_MASTERCARD", "recurrencyNumber"=>"0", "warrantyRefund"=>"30", "salesNature"=>"Afiliado 1", "source"=>"adwWP", "sourceSck"=>"B2", "underWarranty"=>"false", "purchaseSubscription"=>"false", "installmentsNumber"=>"12"}, 
"offer"=>{"paymentMode"=>"PAGAMENTO_UNICO", "key"=>"ad7rmzb4"}}}


{"product"=>{"id"=>"128098", "name"=>"Calcularte", "ucode"=>"ad6623aa-badc-48f2-bff2-6bf92b44bf74", "hasCoProduction"=>"false", "subscription"=>"false"},
 "enotas"=>{"status"=>"NOT_AVAILABLE"}, 
 "affiliate"=>{"id"=>"6928941", "name"=>"Leonardo Colmanetti Correa", "email"=>"", "ucode"=>"5bc56b1d-8022-4054-bfc9-46863bb6d999", "locale"=>"EN", "documents"=>{"0"=>{"value"=>"30228298000152", "type"=>"CNPJ"}}}, 
 "commission"=>{"value"=>"7.24", "currencyCode"=>"BRL"}, 
 "purchase"=>{"transaction"=>"HP19215631957792", "orderDate"=>"1563195780000", "approvedDate"=>"1563195782000", "paymentEngine"=>"hotmart", "status"=>"APPROVED",
  "price"=>{"value"=>"27.9", "currencyCode"=>"BRL"}, "paymentType"=>"CartaoDeCredito", "paymentMethod"=>"CARTAO_CREDITO_MASTERCARD", "recurrencyNumber"=>"3",
   "warrantyRefund"=>"15", "salesNature"=>"Afiliado 1", "source"=>"adw01", "underWarranty"=>"false", "purchaseSubscription"=>"false", "installmentsNumber"=>"1"}, 
 "offer"=>{"paymentMode"=>"ASSINATURA", "key"=>"ywm1xozg"}}



=end