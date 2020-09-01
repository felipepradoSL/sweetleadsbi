class UpdateBingJob < ApplicationJob
  queue_as :default

  def perform(data)


  		data.each do |row|
  			@bing = Bing.find_by(date: Date.yesterday, campaign_id: row["CampaignId"])
				if @bing.present?	
					@bing.average_cpc                                       = row["AverageCpc"]
					@bing.average_cpm                                       = row["AverageCpm"]
					@bing.average_position                                       = row["AveragePosition"]
					@bing.campaign_name                                       = row["CampaignName"].to_s.split('] ').last
					@bing.bidding_strategy_type                                       = row["BiddingStrategyType"]
					@bing.budget                                       = row["Budget"]
					@bing.click_conversion_rate                                       = row["ClickConversionRate"]
					@bing.clicks                                       = row["Clicks"]
					@bing.conversion_rate                                       = row["ConversionRate"]
					@bing.conversions                                       = row["Conversions"]
					@bing.converted_clicks                                       = row["ConvertedClicks"]
					@bing.cost                                       = row["Cost"].to_f
					@bing.ctr                                       = row["Ctr"]
					@bing.impressions                                       = row["Impressions"]
					@bing.return_on_ad_spend                                       = row["ReturnOnAdSpend"]
					@bing.revenue                                       = row["Revenue"]
					
					@bing.save
					sleep 0.1
					Rails.logger.debug("  ============== Atualizado:  #{@bing.attributes} ")
  			else
  				@bing = Bing.new
					@bing.date                                       = Date.yesterday
					@bing.average_cpc                                       = row["AverageCpc"]
					@bing.average_cpm                                       = row["AverageCpm"]
					@bing.average_position                                       = row["AveragePosition"]
					@bing.campaign_name                                       = row["CampaignName"].to_s.split('] ').last
					@bing.campaign_id                                       = row["CampaignId"]
					@bing.bidding_strategy_type                                       = row["BiddingStrategyType"]
					@bing.budget                                       = row["Budget"]
					@bing.click_conversion_rate                                       = row["ClickConversionRate"]
					@bing.clicks                                       = row["Clicks"]
					@bing.conversion_rate                                       = row["ConversionRate"]
					@bing.conversions                                       = row["Conversions"]
					@bing.converted_clicks                                       = row["ConvertedClicks"]
					@bing.cost                                       = row["Cost"].to_f
					@bing.ctr                                       = row["Ctr"]
					@bing.impressions                                       = row["Impressions"]
					@bing.return_on_ad_spend                                       = row["ReturnOnAdSpend"]
					@bing.revenue                                       = row["Revenue"]
					@bing.save
					sleep 0.1
					Rails.logger.debug("  ============== Cadastrado:  #{@bing.attributes} ")
  			end
  		end


  end
end
