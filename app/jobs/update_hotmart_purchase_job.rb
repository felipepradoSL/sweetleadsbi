class UpdateHotmartPurchaseJob < ApplicationJob
  queue_as :default

  def perform()

		res = RestClient.get("https://api-hot-connect.hotmart.com/reports/rest/v2/purchaseDetails?startDate=1563887873506&endDate=1563887992912&rows=5000", :Authorization => "Bearer #{Setting.token_one}" )

		json = JSON.parse(res.body)

		Rails.logger.debug("  ============== attributes:  #{json} ")
		return


		data = json["data"]

  	data.each do |val|

				retro = RetroHotmart.find_by(purchase_transaction: val["purchase"]["transaction"])

				if retro.blank?
					retro = RetroHotmart.new
				end
				retro.commission = val["commission"]	
				retro.productid = val["productId"]	
				retro.productname = val["productName"]	
				retro.transaction = val["transaction"]	
				retro.approveddate = val["approvedDate"]	
				retro.orderdate = val["orderDate"]	
				retro.conversionrate = val["conversionRate"]	
				retro.currencycodefrom = val["currencyCodeFrom"]	
				retro.currencycodeto = val["currencyCodeTo"]	
				retro.exchangeorderrealconversionrate = val["exchangeOrderRealConversionRate"]	
				retro.originalprice = val["originalPrice"]	
				retro.paymenttype = val["paymentType"]	
				retro.price = val["price"]	
				retro.totalvalue = val["totalValue"]	
				retro.salesnature = val["salesNature"]	
				retro.status = val["status"]	
				retro.save

  	end

  end
end