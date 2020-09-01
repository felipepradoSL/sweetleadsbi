class CreateHotmartPurchaseDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :hotmart_purchase_details do |t|

			t.decimal 											:commission
			t.integer 											:productid
			t.string 											:productname
			t.string 											:transaction
			t.date 											:approveddate
			t.date 											:orderdate
			t.decimal 											:conversionrate
			t.string 											:currencycodefrom
			t.string 											:currencycodeto
			t.decimal 											:exchangeorderrealconversionrate
			t.decimal 											:originalprice
			t.string 											:paymenttype
			t.decimal 											:price
			t.decimal 											:totalvalue
			t.string 											:salesnature
			t.string 											:status

      t.timestamps
    end
  end
end
