class CreateLeads < ActiveRecord::Migration[5.2]
  def change
    create_table :leads do |t|
    	t.date 						:date
    	t.string					:product
			t.string 					:clicks
			t.string 					:impressions
			t.string 					:cost
			t.string 					:conversions
			t.string 					:conversions_value
			t.string 					:results
			t.string 					:status
			t.string 					:payment_type
			t.string 					:cms_aff
			t.string 					:src
			t.string 					:original_offer_price
			t.string 					:producer_name
			t.string 					:refusal_reason
			t.string 					:erros

      t.timestamps
    end
  end
end
