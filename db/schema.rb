# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_10_01_174526) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "unaccent"

  create_table "bings", force: :cascade do |t|
    t.string "date"
    t.string "average_cpc"
    t.string "average_cpm"
    t.string "average_position"
    t.string "campaign_name"
    t.string "campaign_id"
    t.string "bidding_strategy_type"
    t.string "budget"
    t.string "click_conversion_rate"
    t.string "clicks"
    t.string "conversion_rate"
    t.string "conversions"
    t.string "converted_clicks"
    t.decimal "cost"
    t.string "ctr"
    t.string "impressions"
    t.string "return_on_ad_spend"
    t.string "revenue"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "eduzzs", force: :cascade do |t|
    t.integer "sale_id"
    t.integer "contract_id"
    t.datetime "date_create"
    t.datetime "date_payment"
    t.string "sale_status"
    t.integer "sale_item_id"
    t.decimal "sale_item_discount"
    t.string "client_first_access_id"
    t.string "sale_recuperacao"
    t.string "sale_funil_infinito"
    t.decimal "sale_amount_win"
    t.decimal "sale_net_gain"
    t.decimal "sale_coop"
    t.decimal "sale_partner"
    t.decimal "sale_fee"
    t.string "sale_others"
    t.decimal "sale_total"
    t.string "sale_payment_method"
    t.integer "client_id"
    t.string "client_name"
    t.string "client_email"
    t.string "client_document"
    t.string "client_cel"
    t.integer "producer_id"
    t.integer "affiliate_id"
    t.string "producer_name"
    t.string "affiliate_name"
    t.string "utm_source"
    t.string "utm_campaign"
    t.string "utm_medium"
    t.string "utm_content"
    t.string "tracker"
    t.integer "content_id"
    t.string "content_title"
    t.integer "content_type_id"
  end

  create_table "googleads", force: :cascade do |t|
    t.string "customer_id"
    t.string "date"
    t.string "campaign_name"
    t.string "campaign_id"
    t.string "account_description_name"
    t.string "clicks"
    t.string "impressions"
    t.decimal "cost"
    t.string "conversions"
    t.string "conversions_value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "hotmart_purchase_details", force: :cascade do |t|
    t.decimal "commission"
    t.integer "productid"
    t.string "productname"
    t.string "transaction"
    t.date "approveddate"
    t.date "orderdate"
    t.decimal "conversionrate"
    t.string "currencycodefrom"
    t.string "currencycodeto"
    t.decimal "exchangeorderrealconversionrate"
    t.decimal "originalprice"
    t.string "paymenttype"
    t.decimal "price"
    t.decimal "totalvalue"
    t.string "salesnature"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "hotmarts", force: :cascade do |t|
    t.string "prod"
    t.string "prod_name"
    t.string "off"
    t.string "price"
    t.string "aff"
    t.string "aff_name"
    t.string "email"
    t.string "name"
    t.string "first_name"
    t.string "last_name"
    t.string "doc"
    t.string "phone_local_code"
    t.string "phone_number"
    t.string "phone_checkout_local_code"
    t.string "phone_checkout_number"
    t.string "address"
    t.string "address_number"
    t.string "address_country"
    t.string "address_district"
    t.string "address_comp"
    t.string "address_city"
    t.string "address_state"
    t.string "address_zip_code"
    t.string "transactionn"
    t.string "xcod"
    t.string "src"
    t.string "status"
    t.string "payment_engine"
    t.string "payment_type"
    t.string "hotkey"
    t.string "name_subscription_plan"
    t.string "subscriber_code"
    t.string "recurrency_period"
    t.string "recurrency"
    t.string "cms_marketplace"
    t.string "cms_vendor"
    t.decimal "cms_aff"
    t.string "coupon_code"
    t.string "callback_type"
    t.string "subscription_status"
    t.string "transaction_ext"
    t.string "sck"
    t.string "purchase_date"
    t.string "confirmation_purchase_date"
    t.string "billet_url"
    t.string "currency_code_from"
    t.decimal "original_offer_price"
    t.string "currency"
    t.string "billet_barcode"
    t.string "producer_name"
    t.string "producer_document"
    t.string "producer_legal_nature"
    t.string "currency_code_from_"
    t.string "refusal_reason"
    t.string "doc_type"
    t.string "full_price"
    t.string "warranty_date"
    t.string "cms_aff_currency"
    t.string "product_support_email"
    t.string "amount"
    t.string "affiliate"
    t.string "productName"
    t.string "productUcode"
    t.string "productCategory"
    t.json "buyerVO", default: {}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "leads", force: :cascade do |t|
    t.date "date"
    t.string "product"
    t.string "clicks"
    t.string "impressions"
    t.string "cost"
    t.string "conversions"
    t.string "conversions_value"
    t.string "results"
    t.string "status"
    t.string "payment_type"
    t.string "cms_aff"
    t.string "src"
    t.string "original_offer_price"
    t.string "producer_name"
    t.string "refusal_reason"
    t.string "erros"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reports", force: :cascade do |t|
    t.string "date"
    t.string "produto"
    t.string "bing_average_cpc"
    t.string "bing_average_cpm"
    t.string "bing_average_position"
    t.string "bing_campaign_id"
    t.string "bing_bidding_strategy_type"
    t.string "bing_budget"
    t.string "bing_click_conversion_rate"
    t.string "bing_clicks"
    t.string "bing_conversion_rate"
    t.string "bing_conversions"
    t.string "bing_converted_clicks"
    t.decimal "bing_cost"
    t.string "bing_ctr"
    t.string "bing_impressions"
    t.string "bing_return_on_ad_spend"
    t.string "bing_revenue"
    t.string "google_customer_id"
    t.string "google_campaign_id"
    t.string "google_account_description_name"
    t.string "google_clicks"
    t.string "google_impressions"
    t.decimal "google_cost"
    t.string "google_conversions"
    t.string "google_conversions_value"
    t.integer "hotmart_product_id"
    t.string "hotmart_product_ucode"
    t.string "hotmart_product_hascoproduction"
    t.string "hotmart_product_subscription"
    t.string "hotmart_enotas_status"
    t.integer "hotmart_affiliate_id"
    t.string "hotmart_affiliate_name"
    t.string "hotmart_affiliate_email"
    t.string "hotmart_affiliate_ucode"
    t.string "hotmart_affiliate_locale"
    t.decimal "hotmart_commission_value"
    t.string "hotmart_commission_currencycode"
    t.string "hotmart_purchase_transaction"
    t.string "hotmart_purchase_orderdate"
    t.string "hotmart_purchase_approveddate"
    t.string "hotmart_purchase_paymentengine"
    t.string "hotmart_purchase_status"
    t.decimal "hotmart_purchase_price"
    t.string "hotmart_purchase_currencycode"
    t.string "hotmart_purchase_paymenttype"
    t.string "hotmart_purchase_paymentmethod"
    t.integer "hotmart_purchase_recurrencynumber"
    t.integer "hotmart_purchase_warrantyrefund"
    t.string "hotmart_purchase_salesnature"
    t.string "hotmart_purchase_source"
    t.boolean "hotmart_purchase_underwarranty"
    t.boolean "hotmart_purchase_subscription"
    t.integer "hotmart_purchase_installmentsnumber"
    t.integer "hotmart_offer_paymentmode"
    t.integer "hotmart_offer_key"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "eduzz_sale_id"
    t.string "eduzz_contract_id"
    t.string "eduzz_date_create"
    t.string "eduzz_date_payment"
    t.string "eduzz_sale_status"
    t.string "eduzz_sale_item_id"
    t.decimal "eduzz_sale_item_discount"
    t.string "eduzz_client_first_access_id"
    t.string "eduzz_sale_recuperacao"
    t.string "eduzz_sale_funil_infinito"
    t.decimal "eduzz_sale_amount_win"
    t.decimal "eduzz_sale_net_gain"
    t.decimal "eduzz_sale_coop"
    t.decimal "eduzz_sale_partner"
    t.decimal "eduzz_sale_fee"
    t.string "eduzz_sale_others"
    t.decimal "eduzz_sale_total"
    t.string "eduzz_sale_payment_method"
    t.string "eduzz_client_id"
    t.string "eduzz_client_name"
    t.string "eduzz_client_email"
    t.string "eduzz_client_document"
    t.string "eduzz_client_cel"
    t.string "eduzz_producer_id"
    t.string "eduzz_affiliate_id"
    t.string "eduzz_producer_name"
    t.string "eduzz_affiliate_name"
    t.string "eduzz_utm_source"
    t.string "eduzz_utm_campaign"
    t.string "eduzz_utm_medium"
    t.string "eduzz_utm_content"
    t.string "eduzz_tracker"
    t.string "eduzz_content_id"
    t.string "eduzz_content_title"
    t.string "eduzz_content_type_id"
  end

  create_table "retro_hotmarts", force: :cascade do |t|
    t.integer "product_id"
    t.string "product_name"
    t.string "product_ucode"
    t.boolean "product_hascoproduction"
    t.boolean "product_subscription"
    t.string "enotas_status"
    t.integer "affiliate_id"
    t.string "affiliate_name"
    t.string "affiliate_email"
    t.string "affiliate_ucode"
    t.string "affiliate_locale"
    t.decimal "commission_value"
    t.string "commission_currencycode"
    t.string "purchase_transaction"
    t.string "purchase_orderdate"
    t.string "purchase_approveddate"
    t.string "purchase_paymentengine"
    t.string "purchase_status"
    t.decimal "purchase_price"
    t.string "purchase_currencycode"
    t.string "purchase_paymenttype"
    t.string "purchase_paymentmethod"
    t.integer "purchase_recurrencynumber"
    t.integer "purchase_warrantyrefund"
    t.string "purchase_salesnature"
    t.string "purchase_source"
    t.boolean "purchase_underwarranty"
    t.boolean "purchase_subscription"
    t.integer "purchase_installmentsnumber"
    t.integer "offer_paymentmode"
    t.integer "offer_key"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "settings", force: :cascade do |t|
    t.string "var", null: false
    t.text "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["var"], name: "index_settings_on_var", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "phone"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
