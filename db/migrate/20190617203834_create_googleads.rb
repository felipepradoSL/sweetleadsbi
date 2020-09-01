class CreateGoogleads < ActiveRecord::Migration[5.2]
  def change
    create_table :googleads do |t|
    	t.string 						:customer_id
    	t.string 						:date
      t.string            :campaign_name
    	t.string 						:campaign_id
    	t.string 						:account_description_name
    	t.string 						:clicks
    	t.string 						:impressions
    	t.string 						:cost
    	t.string 						:conversions
    	t.string 						:conversions_value
      t.timestamps
    end
  end
end


#(ExternalCustomerId, Date, CampaignName, AccountDescriptiveName, Clicks, Impressions, Cost, Conversions, ConversionValue)