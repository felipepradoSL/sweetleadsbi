class DropReports < ActiveRecord::Migration[5.2]
  def change
  	drop_table :reports

    create_table :reports do |t|
    	t.string :date
    	t.string :produto
    	######################################################
        t.string :bing_average_cpc
        t.string :bing_average_cpm
        t.string :bing_average_position
        t.string :bing_campaign_id
        t.string :bing_bidding_strategy_type
        t.string :bing_budget
        t.string :bing_click_conversion_rate
        t.string :bing_clicks
        t.string :bing_conversion_rate
        t.string :bing_conversions
        t.string :bing_converted_clicks
        t.decimal :bing_cost
        t.string :bing_ctr
        t.string :bing_impressions
        t.string :bing_return_on_ad_spend
        t.string :bing_revenue
        ######################################################
    	t.string :google_customer_id
    	t.string :google_campaign_id
    	t.string :google_account_description_name
    	t.string :google_clicks
    	t.string :google_impressions
    	t.decimal :google_cost
    	t.string :google_conversions
    	t.string :google_conversions_value
    	######################################################
			t.integer :hotmart_product_id
			t.string :hotmart_product_ucode
			t.string :hotmart_product_hascoproduction
			t.string :hotmart_product_subscription
			t.string :hotmart_enotas_status
			t.integer :hotmart_affiliate_id
			t.string :hotmart_affiliate_name
			t.string :hotmart_affiliate_email
			t.string :hotmart_affiliate_ucode
			t.string :hotmart_affiliate_locale
			t.decimal :hotmart_commission_value
			t.string :hotmart_commission_currencycode
			t.string :hotmart_purchase_transaction
			t.string :hotmart_purchase_orderdate
			t.string :hotmart_purchase_approveddate
			t.string :hotmart_purchase_paymentengine
			t.string :hotmart_purchase_status
			t.decimal :hotmart_purchase_price
			t.string :hotmart_purchase_currencycode
			t.string :hotmart_purchase_paymenttype
			t.string :hotmart_purchase_paymentmethod
			t.integer :hotmart_purchase_recurrencynumber
			t.integer :hotmart_purchase_warrantyrefund
			t.string :hotmart_purchase_salesnature
			t.string :hotmart_purchase_source
			t.boolean :hotmart_purchase_underwarranty
			t.boolean :hotmart_purchase_subscription
			t.integer :hotmart_purchase_installmentsnumber
			t.integer :hotmart_offer_paymentmode
			t.integer :hotmart_offer_key
			t.timestamps
    end
  end
end
