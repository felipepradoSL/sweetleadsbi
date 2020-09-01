class ChangeColumnsFromHotmart < ActiveRecord::Migration[5.2]
  def change
		change_column :hotmarts, :cms_aff, 'decimal USING CAST(cms_aff AS decimal)'
		change_column :hotmarts, :original_offer_price, 'decimal USING CAST(original_offer_price AS decimal)'
  end
end
