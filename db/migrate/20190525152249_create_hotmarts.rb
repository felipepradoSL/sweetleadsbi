class CreateHotmarts < ActiveRecord::Migration[5.2]
  def change
    create_table :hotmarts do |t|
			t.string 					:prod
			t.string 					:prod_name
			t.string 					:off
			t.string 					:price
			t.string 					:aff
			t.string 					:aff_name
			t.string 					:email
			t.string 					:name
			t.string 					:first_name
			t.string 					:last_name
			t.string 					:doc
			t.string 					:phone_local_code
			t.string 					:phone_number
			t.string 					:phone_checkout_local_code
			t.string 					:phone_checkout_number
			t.string 					:address
			t.string 					:address_number
			t.string 					:address_country
			t.string 					:address_district
			t.string 					:address_comp
			t.string 					:address_city
			t.string 					:address_state
			t.string 					:address_zip_code
			t.string 					:transactionn
			t.string 					:xcod
			t.string 					:src
			t.string 					:status
			t.string 					:payment_engine
			t.string 					:payment_type
			t.string 					:hotkey
			t.string 					:name_subscription_plan
			t.string 					:subscriber_code
			t.string 					:recurrency_period
			t.string 					:recurrency
			t.string 					:cms_marketplace
			t.string 					:cms_vendor
			t.string 					:cms_aff
			t.string 					:coupon_code
			t.string 					:callback_type
			t.string 					:subscription_status
			t.string 					:transaction_ext
			t.string 					:sck
			t.string 					:purchase_date
			t.string 					:confirmation_purchase_date
			t.string 					:billet_url
			t.string 					:currency_code_from
			t.string 					:original_offer_price
			t.string 					:currency
			t.string 					:billet_barcode
			t.string 					:producer_name
			t.string 					:producer_document
			t.string 					:producer_legal_nature
			t.string 					:currency_code_from_
			t.string 					:refusal_reason
			t.string 					:doc_type
			t.string 					:full_price
			t.string 					:warranty_date
			t.string 					:cms_aff_currency
			t.string 					:product_support_email
			t.string 					:amount
			t.string 					:affiliate
			t.string 					:productName
			t.string 					:productUcode
			t.string 					:productCategory
			t.json 						:buyerVO, default: {}
      t.timestamps
    end
  end
end
