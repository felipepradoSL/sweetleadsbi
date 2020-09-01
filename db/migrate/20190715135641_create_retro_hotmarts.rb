class CreateRetroHotmarts < ActiveRecord::Migration[5.2]
  def change
    create_table :retro_hotmarts do |t|
    	t.integer 				:product_id
    	t.string 				:product_name
    	t.string 				:product_ucode
    	t.boolean 				:product_hascoproduction
    	t.boolean 				:product_subscription

    	t.string 				:enotas_status

    	t.integer 				:affiliate_id
    	t.string 				:affiliate_name
    	t.string 				:affiliate_email
    	t.string 				:affiliate_ucode
    	t.string 				:affiliate_locale

    	t.decimal 				:commission_value
    	t.string 				:commission_currencycode

    	t.string 				:purchase_transaction
    	t.string 				:purchase_orderdate
    	t.string 				:purchase_approveddate
    	t.string 				:purchase_paymentengine
    	t.string 				:purchase_status
    	t.decimal 			:purchase_price
    	t.string 				:purchase_currencycode
    	t.string 				:purchase_paymenttype
    	t.string 				:purchase_paymentmethod
    	t.integer 			:purchase_recurrencynumber
    	t.integer 			:purchase_warrantyrefund
    	t.string 				:purchase_salesnature
    	t.string 				:purchase_source
    	t.boolean 			:purchase_underwarranty
    	t.boolean 			:purchase_subscription
    	t.integer 			:purchase_installmentsnumber

    	
    	t.integer 			:offer_paymentmode
    	t.integer 			:offer_key
      

      t.timestamps
    end
  end
end



=begin

{"product"=>{"id"=>"128098", "name"=>"Calcularte", "ucode"=>"ad6623aa-badc-48f2-bff2-6bf92b44bf74", "hasCoProduction"=>"false", "subscription"=>"false"},
 "enotas"=>{"status"=>"NOT_AVAILABLE"}, 
 "affiliate"=>{"id"=>"6928941", "name"=>"Leonardo Colmanetti Correa", "email"=>"", "ucode"=>"5bc56b1d-8022-4054-bfc9-46863bb6d999", "locale"=>"EN", "documents"=>{"0"=>{"value"=>"30228298000152", "type"=>"CNPJ"}}}, 
 "commission"=>{"value"=>"7.24", "currencyCode"=>"BRL"}, 
 "purchase"=>{"transaction"=>"HP19215631957792", "orderDate"=>"1563195780000", "approvedDate"=>"1563195782000", "paymentEngine"=>"hotmart", "status"=>"APPROVED", 
 "price"=>{"value"=>"27.9", "currencyCode"=>"BRL"}, "paymentType"=>"CartaoDeCredito", "paymentMethod"=>"CARTAO_CREDITO_MASTERCARD", "recurrencyNumber"=>"3",
 "warrantyRefund"=>"15", "salesNature"=>"Afiliado 1", "source"=>"adw01", "underWarranty"=>"false", "purchaseSubscription"=>"false", "installmentsNumber"=>"1"}, 
 "offer"=>{"paymentMode"=>"ASSINATURA", "key"=>"ywm1xozg"}}


=end