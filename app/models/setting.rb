require 'json'
require 'rest-client'
require 'net/http'
require 'uri'

# RailsSettings Model
class Setting < RailsSettings::Base

  field :token_one, default: ""
  field :token_two, default: ""

  field :public_key, default: ""
  field :api_key, default: ""
  field :jwt, default: ""

  def self.atualizar_jwt
    res = RestClient.post("https://api2.eduzz.com/credential/generate_token", {"email" => "contato@sweetleads.com.br", "publickey" => "43725762", "apikey" => "26319a71d8"})
    json = JSON.parse(res.body)
    jwt = json["data"]["token"]
    Setting.jwt = jwt
    Setting.atualizar_eduzz(jwt)

  end

  def self.atualizar_eduzz(jwt)
    Rails.logger.debug("  ============== jwt:  #{jwt} ")

    res = RestClient.get "https://api2.eduzz.com/sale/get_sale_list?start_date=2018-04-01&end_date=#{Date.today.year}-#{Date.today.month}-#{Date.today.day}&page=1", 
    {"token" => "#{jwt}", "publickey" => "43725762", "apikey" => "26319a71d8"}

    json = JSON.parse(res.body)

    Rails.logger.debug("  ============== res:  #{json} ")

    data = json["data"]

    data.each do |val|

        eduzz = Eduzz.find_by(sale_id: val["sale_id"])

        if eduzz.blank?
          eduzz = Eduzz.new
        end

        eduzz.sale_id = val["sale_id"]
        eduzz.contract_id = val["contract_id"]
        eduzz.date_create = val["date_create"].to_datetime
        eduzz.date_payment = val["date_payment"].to_datetime unless val["date_payment"].blank?
        eduzz.sale_status = val["sale_status"]
        eduzz.sale_item_id = val["sale_item_id"]
        eduzz.sale_item_discount = val["sale_item_discount"].to_f
        eduzz.client_first_access_id = val["client_first_access_id"]
        eduzz.sale_recuperacao = val["sale_recuperacao"]
        eduzz.sale_funil_infinito = val["sale_funil_infinito"]
        eduzz.sale_amount_win = val["sale_amount_win"].to_f
        eduzz.sale_net_gain = val["sale_net_gain"].to_f
        eduzz.sale_coop = val["sale_coop"].to_f
        eduzz.sale_partner = val["sale_partner"].to_f
        eduzz.sale_fee = val["sale_fee"].to_f
        eduzz.sale_others = val["sale_others"]
        eduzz.sale_total = val["sale_total"].to_f
        eduzz.sale_payment_method = val["sale_payment_method"]
        eduzz.client_id = val["client_id"]
        eduzz.client_name = val["client_name"]
        eduzz.client_email = val["client_email"]
        eduzz.client_document = val["client_document"]
        eduzz.client_cel = val["client_cel"]
        eduzz.producer_id = val["producer_id"]
        eduzz.affiliate_id = val["affiliate_id"]
        eduzz.producer_name = val["producer_name"]
        eduzz.affiliate_name = val["affiliate_name"]
        eduzz.utm_source = val["utm_source"]
        eduzz.utm_campaign = val["utm_campaign"]
        eduzz.utm_medium = val["utm_medium"]
        eduzz.utm_content = val["utm_content"]
        eduzz.tracker = val["tracker"]
        eduzz.content_id = val["content_id"]
        eduzz.content_title = val["content_title"]
        eduzz.content_type_id = val["content_type_id"]

        eduzz.save

    end

=begin
res:  {"success":true,"data":[{"sale_id":5466647,"contract_id":null,"date_create":"2019-09-23 10:25:55","date_payment":null,"sale_status":11,
"sale_item_id":5473527,"sale_item_discount":0,"client_first_access_id":null,"sale_recuperacao":1,"sale_funil_infinito":null,"sale_amount_win":0,
"sale_net_gain":0,"sale_coop":null,"sale_partner":0,"sale_fee":0,"sale_others":0,"sale_total":147,"sale_payment_method":"Boleto Banc\u00e1rio",
"client_id":87553612,"client_name":"Teste teste","client_email":"sedfsdfsdfsdf@fee.com","client_document":"29289805803","client_cel":"11111111111",
"producer_id":903523,"affiliate_id":43725762,"producer_name":"OZIEL ALVES DE ALENCAR FILHO 91295769387","affiliate_name":"Sweet Leads Empreendimentos Digitais",
"utm_source":null,"utm_campaign":null,"utm_medium":null,"utm_content":null,"tracker":null,"content_id":3343,"content_title":"Kit de T\u00e9cnica para Guitarra Rock",
"content_type_id":1},{"sale_id":5450243,"contract_id":null,"date_create":"2019-09-20 11:34:02","date_payment":null,"sale_status":11,"sale_item_id":5456197,
"sale_item_discount":0,"client_first_access_id":null,"sale_recuperacao":1,"sale_funil_infinito":null,"sale_amount_win":0,"sale_net_gain":0,"sale_coop":null,
"sale_partner":0,"sale_fee":0,"sale_others":0,"sale_total":29,"sale_payment_method":"Boleto Banc\u00e1rio","client_id":87553612,"client_name":"Teste teste",
"client_email":"sedfsdfsdfsdf@fee.com","client_document":"29289805803","client_cel":"11111111111","producer_id":22263133,"affiliate_id":43725762,
"producer_name":"Wendel Santos","affiliate_name":"Sweet Leads Empreendimentos Digitais","utm_source":null,"utm_campaign":null,"utm_medium":null,
"utm_content":"segundo bot\u00e3o","tracker":null,"content_id":260269,"content_title":"Apostila do Sabonete Artesanal Passo a Passo + Receitas","content_type_id":1}],
"profile":{"start":1569930731.491839,
"token":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhdWQiOiI0MzcyNTc2MiIsImV4cCI6OTAwMDAsImlhdCI6MTU2OTkzMDczMCwiaXNzIjoibXllZHV6ei1hcGktdXNlciIsInN1YiI6NDM3MjU3NjJ9.TXeMS+fcF4I5FzJBvmbpv\/7Z8sNwhBNRmCVhc+gburo=",
"token_valid_until":"2019-10-02 09:52:10","finish":1569930731.956375,"process":0.4645359516143799},"paginator":{"page":1,"size":25,"totalPages":1,"totalRows":2}} 


=end


  end

  def self.report
    ((Date.today-62.days)..(Date.today)).each do |date|
        Googlead.where("to_date(googleads.date, 'YY MM DD') BETWEEN '#{date.to_date.to_s(:db)}' AND '#{date.to_date.to_s(:db)}'").each do |googlead|
            report = Report.find_by(date: "#{date}", produto: "#{googlead.campaign_name}")
            if report.blank?
                report = Report.new
                report.date = "#{date}"
                report.produto = "#{googlead.campaign_name}"
            elsif report.updated_at.day != DateTime.now.day
                report.google_clicks = 0
                report.google_impressions = 0
                report.google_cost = 0
                report.google_conversions = 0
                report.google_conversions_value = 0
                report.bing_clicks = 0
                report.bing_conversions = 0
                report.bing_cost = 0
                report.bing_impressions = 0
                report.hotmart_commission_value = 0
                report.eduzz_sale_amount_win = 0
                report.eduzz_sale_total = 0
            end
            report.google_customer_id = googlead.customer_id
            report.google_campaign_id = googlead.campaign_id
            report.google_account_description_name = googlead.account_description_name
            report.google_clicks = report.google_clicks.to_i + googlead.clicks.to_i
            report.google_impressions = report.google_impressions.to_i + googlead.impressions.to_i
            report.google_cost = report.google_cost.to_f + googlead.cost.to_f
            report.google_conversions = report.google_conversions.to_i + googlead.conversions.to_i
            report.google_conversions_value = report.google_conversions_value.to_i + googlead.conversions_value.to_i
            report.save
            
        end


        Bing.where("to_date(bings.date, 'YY MM DD') BETWEEN '#{date.to_date.to_s(:db)}' AND '#{date.to_date.to_s(:db)}'").each do |bing|
            report = Report.find_by(date: "#{date}", produto: "#{bing.campaign_name}")
            if report.blank?
                report = Report.new
                report.date = "#{date}"
                report.produto = "#{bing.campaign_name}"
            elsif report.updated_at.day != DateTime.now.day
                report.bing_clicks = 0
                report.bing_conversions = 0
                report.bing_cost = 0
                report.bing_impressions = 0
                report.hotmart_commission_value = 0
                report.eduzz_sale_amount_win = 0
                report.eduzz_sale_total = 0
            end
            report.bing_average_cpc = bing.average_cpc
            report.bing_average_cpm = bing.average_cpm
            report.bing_average_position = bing.average_position
            report.bing_campaign_id = bing.campaign_id
            report.bing_bidding_strategy_type = bing.bidding_strategy_type
            report.bing_budget = bing.budget
            report.bing_click_conversion_rate = bing.click_conversion_rate
            report.bing_clicks = report.bing_clicks.to_i + bing.clicks.to_i
            report.bing_conversion_rate = bing.conversion_rate
            report.bing_conversions = report.bing_conversions.to_i + bing.conversions.to_i
            report.bing_converted_clicks = bing.converted_clicks
            report.bing_cost = report.bing_cost.to_f + bing.cost.to_f
            report.bing_ctr = bing.ctr
            report.bing_impressions = report.bing_impressions.to_i + bing.impressions.to_i
            report.bing_return_on_ad_spend = bing.return_on_ad_spend
            report.bing_revenue = bing.revenue
            report.save
        end


        RetroHotmart.where("to_date(retro_hotmarts.purchase_orderdate, 'YY MM DD') BETWEEN '#{date.to_date.to_s(:db)}' AND '#{date.to_date.to_s(:db)}'").where("(UPPER(unaccent(retro_hotmarts.purchase_status)) LIKE 'COMPLETE' OR UPPER(unaccent(retro_hotmarts.purchase_status)) LIKE 'APPROVED')").each do |hotmart|
            report = Report.find_by(date: "#{date}", produto: "#{hotmart.product_name}")
            if report.blank?
                report = Report.new
                report.date = "#{date}"
                report.produto = "#{hotmart.product_name}"
            elsif report.updated_at.day != DateTime.now.day
                report.hotmart_commission_value = 0
                report.eduzz_sale_amount_win = 0
                report.eduzz_sale_total = 0
            end
            report.hotmart_product_id = hotmart.product_id
            report.hotmart_product_ucode = hotmart.product_ucode
            report.hotmart_product_hascoproduction = hotmart.product_hascoproduction
            report.hotmart_product_subscription = hotmart.product_subscription
            report.hotmart_enotas_status = hotmart.enotas_status
            report.hotmart_affiliate_id = hotmart.affiliate_id
            report.hotmart_affiliate_name = hotmart.affiliate_name
            report.hotmart_affiliate_email = hotmart.affiliate_email
            report.hotmart_affiliate_ucode = hotmart.affiliate_ucode
            report.hotmart_affiliate_locale = hotmart.affiliate_locale
            report.hotmart_commission_value = (report.hotmart_commission_value.to_f + hotmart.commission_value.to_f) 
            report.hotmart_commission_currencycode = hotmart.commission_currencycode
            report.hotmart_purchase_transaction = "#{report.hotmart_purchase_transaction} #{hotmart.purchase_transaction}" 
            report.hotmart_purchase_orderdate = hotmart.purchase_orderdate
            report.hotmart_purchase_approveddate = hotmart.purchase_approveddate
            report.hotmart_purchase_paymentengine = hotmart.purchase_paymentengine
            report.hotmart_purchase_status = hotmart.purchase_status 
            report.hotmart_purchase_price = hotmart.purchase_price
            report.hotmart_purchase_currencycode = hotmart.purchase_currencycode
            report.hotmart_purchase_paymenttype = hotmart.purchase_paymenttype
            report.hotmart_purchase_paymentmethod = hotmart.purchase_paymentmethod
            report.hotmart_purchase_recurrencynumber = hotmart.purchase_recurrencynumber
            report.hotmart_purchase_warrantyrefund = hotmart.purchase_warrantyrefund
            report.hotmart_purchase_salesnature = hotmart.purchase_salesnature
            report.hotmart_purchase_source = hotmart.purchase_source
            report.hotmart_purchase_underwarranty = hotmart.purchase_underwarranty
            report.hotmart_purchase_subscription = hotmart.purchase_subscription
            report.hotmart_purchase_installmentsnumber = hotmart.purchase_installmentsnumber
            report.hotmart_offer_paymentmode = hotmart.offer_paymentmode
            report.hotmart_offer_key         = hotmart.offer_key
            report.save
            
        end


        Eduzz.where("to_date(cast(eduzzs.date_create as TEXT), 'YY MM DD') BETWEEN '#{date.to_date.to_s(:db)}' AND '#{date.to_date.to_s(:db)}'").each do |eduzz|
            report = Report.find_by(date: "#{date}", produto: "#{eduzz.content_title}")
            if report.blank?
                report = Report.new
                report.date = "#{date}"
                report.produto = "#{eduzz.content_title}"
            elsif report.updated_at.day != DateTime.now.day
                report.eduzz_sale_amount_win = 0
                report.eduzz_sale_total = 0
            end
            report.eduzz_sale_id = eduzz.sale_id
            report.eduzz_contract_id = eduzz.contract_id
            report.eduzz_date_create = eduzz.date_create
            report.eduzz_date_payment = eduzz.date_payment
            report.eduzz_sale_status = eduzz.sale_status
            report.eduzz_sale_item_id = eduzz.sale_item_id
            report.eduzz_sale_item_discount = eduzz.sale_item_discount.to_f
            report.eduzz_client_first_access_id = eduzz.client_first_access_id
            report.eduzz_sale_recuperacao = eduzz.sale_recuperacao
            report.eduzz_sale_funil_infinito = eduzz.sale_funil_infinito
            report.eduzz_sale_amount_win = eduzz.sale_amount_win.to_f
            report.eduzz_sale_net_gain = eduzz.sale_net_gain.to_f
            report.eduzz_sale_coop = eduzz.sale_coop.to_f
            report.eduzz_sale_partner = eduzz.sale_partner.to_f
            report.eduzz_sale_fee = eduzz.sale_fee.to_f
            report.eduzz_sale_others = eduzz.sale_others
            report.eduzz_sale_total = eduzz.sale_total.to_f
            report.eduzz_sale_payment_method = eduzz.sale_payment_method
            report.eduzz_client_id = eduzz.client_id
            report.eduzz_client_name = eduzz.client_name
            report.eduzz_client_email = eduzz.client_email
            report.eduzz_client_document = eduzz.client_document
            report.eduzz_client_cel = eduzz.client_cel
            report.eduzz_producer_id = eduzz.producer_id
            report.eduzz_affiliate_id = eduzz.affiliate_id
            report.eduzz_producer_name = eduzz.producer_name
            report.eduzz_affiliate_name = eduzz.affiliate_name
            report.eduzz_utm_source = eduzz.utm_source
            report.eduzz_utm_campaign = eduzz.utm_campaign
            report.eduzz_utm_medium = eduzz.utm_medium
            report.eduzz_utm_content = eduzz.utm_content
            report.eduzz_tracker = eduzz.tracker
            report.eduzz_content_id = eduzz.content_id
            report.eduzz_content_title = eduzz.content_title
            report.eduzz_content_type_id = eduzz.content_type_id

            report.save
            
        end

    end

  end

  def self.atualizar

    res = RestClient.post "https://api-sec-vlc.hotmart.com/security/oauth/token", {grant_type: 'client_credentials', client_id: 'd9094a63-512a-41c2-b4d5-b079adb0f70e', client_secret: '81fdbe11-6793-4bcc-a8a6-ad9ec7dfec6d'}, :Authorization => 'Basic ZDkwOTRhNjMtNTEyYS00MWMyLWI0ZDUtYjA3OWFkYjBmNzBlOjgxZmRiZTExLTY3OTMtNGJjYy1hOGE2LWFkOWVjN2RmZWM2ZA=='
    json = JSON.parse(res.body)
    token_one = json["access_token"]
    Setting.token_one = token_one

    res = RestClient.post "https://api-sec-vlc.hotmart.com/security/oauth/token", {grant_type: 'client_credentials', client_id: 'fa819c71-17a0-4af4-ad88-08f2a7af0f73', client_secret: 'f3bb88ca-0e65-4b7c-b870-3f5c846bb16a'}, :Authorization => 'Basic ZmE4MTljNzEtMTdhMC00YWY0LWFkODgtMDhmMmE3YWYwZjczOmYzYmI4OGNhLTBlNjUtNGI3Yy1iODcwLTNmNWM4NDZiYjE2YQ=='
    json = JSON.parse(res.body)
  	token_two = json["access_token"]
    Setting.token_two = token_two

    Rails.logger.debug("  ============== Iniciando atualização ... ")
    sleep 1
    Setting.update_hotmart(token_one.to_s)
    sleep 1
    Setting.update_hotmart(token_two.to_s)

  end

  def self.update_hotmart token



  header = {
    'Authorization': "Bearer #{token}"
  }

    #"https://api-hot-connect.hotmart.com/reports/rest/v2/history?startDate=1546300800000&endDate=1563148800000&rows=5000"

    res = RestClient.get("https://api-hot-connect.hotmart.com/reports/rest/v2/history?transactionStatus=APPROVED&startDate=#{(DateTime.now-60.days).strftime('%Q')}&endDate=#{(DateTime.now+1.days).strftime('%Q')}&rows=5000", header)
    json = JSON.parse(res.body)

    data = json["data"]

    res = RestClient.get("https://api-hot-connect.hotmart.com/reports/rest/v2/history?transactionStatus=COMPLETE&startDate=#{(DateTime.now-60.days).strftime('%Q')}&endDate=#{(DateTime.now+1.days).strftime('%Q')}&rows=5000", header)
    json = JSON.parse(res.body)

    data = data+json["data"]

    res = RestClient.get("https://api-hot-connect.hotmart.com/reports/rest/v2/history?transactionStatus=REFUNDED&startDate=#{(DateTime.now-60.days).strftime('%Q')}&endDate=#{(DateTime.now+1.days).strftime('%Q')}&rows=5000", header)
    json = JSON.parse(res.body)

    data = data+json["data"]

    res = RestClient.get("https://api-hot-connect.hotmart.com/reports/rest/v2/history?transactionStatus=CHARGEBACK&startDate=#{(DateTime.now-60.days).strftime('%Q')}&endDate=#{(DateTime.now+1.days).strftime('%Q')}&rows=5000", header)
    json = JSON.parse(res.body)

    data = data+json["data"]

    res = RestClient.get("https://api-hot-connect.hotmart.com/reports/rest/v2/history?transactionStatus=CANCELLED&startDate=#{(DateTime.now-60.days).strftime('%Q')}&endDate=#{(DateTime.now+1.days).strftime('%Q')}&rows=5000", header)
    json = JSON.parse(res.body)

    data = data+json["data"]

    res = RestClient.get("https://api-hot-connect.hotmart.com/reports/rest/v2/history?transactionStatus=PROTESTED&startDate=#{(DateTime.now-60.days).strftime('%Q')}&endDate=#{(DateTime.now+1.days).strftime('%Q')}&rows=5000", header)
    json = JSON.parse(res.body)

    data = data+json["data"]

    data.each do |val|

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
