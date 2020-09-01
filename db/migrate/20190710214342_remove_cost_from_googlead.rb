class RemoveCostFromGooglead < ActiveRecord::Migration[5.2]
  def change
		change_column :googleads, :cost, 'decimal USING CAST(cost AS decimal)'
		change_column :googleads, :conversions_value, 'decimal USING CAST(conversions_value AS decimal)'
  end
end
