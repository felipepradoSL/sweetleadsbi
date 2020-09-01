class CreateBings < ActiveRecord::Migration[5.2]
  def change
    create_table :bings do |t|
    	t.string 						:date
      t.string            :average_cpc
      t.string            :average_cpm
      t.string            :average_position
      t.string            :campaign_name
    	t.string 						:campaign_id
    	t.string 						:bidding_strategy_type
    	t.string 						:budget
    	t.string 						:click_conversion_rate
    	t.string 						:clicks
    	t.string 						:conversion_rate
    	t.string 						:conversions
    	t.string 						:converted_clicks
    	t.decimal 					:cost
    	t.string 						:ctr
    	t.string 						:impressions
    	t.string 						:return_on_ad_spend
    	t.string 						:revenue
      t.timestamps
    end
  end
end




=begin

            'CampaignName': campaign.getName(),
            'CampaignId': campaign.getId(),
            'BiddingStrategyType': campaign.getBiddingStrategyType(),
            'Budget': campaign.getBudget().getName(),
            'ClickConversionRate': metrics.getClickConversionRate(),
            'Clicks': metrics.getClicks(),
            'ConversionRate': metrics.getConversionRate(),
            'Conversions': metrics.getConversions(),
            'ConvertedClicks': metrics.getConvertedClicks(),
            'Cost': metrics.getCost(),
            'Ctr': metrics.getCtr(),
            'Impressions': metrics.getImpressions(),
            'ReturnOnAdSpend': metrics.getReturnOnAdSpend(),
            'Revenue': metrics.getRevenue()
=end
