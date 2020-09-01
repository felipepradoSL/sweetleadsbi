class CreateEduzz < ActiveRecord::Migration[5.2]
  def change
    create_table :eduzzs do |t|
      t.string :sale_id
      t.string :contract_id
      t.datetime :date_create
      t.datetime :date_payment
      t.string :sale_status
      t.string :sale_item_id
      t.decimal :sale_item_discount
      t.string :client_first_access_id
      t.string :sale_recuperacao
      t.string :sale_funil_infinito
      t.decimal :sale_amount_win
      t.decimal :sale_net_gain
      t.decimal :sale_coop
      t.decimal :sale_partner
      t.decimal :sale_fee
      t.string :sale_others
      t.decimal :sale_total
      t.string :sale_payment_method
      t.string :client_id
      t.string :client_name
      t.string :client_email
      t.string :client_document
      t.string :client_cel
      t.string :producer_id
      t.string :affiliate_id
      t.string :producer_name
      t.string :affiliate_name
      t.string :utm_source
      t.string :utm_campaign
      t.string :utm_medium
      t.string :utm_content
      t.string :tracker
      t.string :content_id
      t.string :content_title
      t.string :content_type_id
    end
  end
end
