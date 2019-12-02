class ChangeCarCategoryColumnsTypes < ActiveRecord::Migration[5.2]
  def change
    change_column :car_categories, :daily_rate, :float 
    change_column :car_categories, :car_insurance, :float
    change_column :car_categories, :third_party_insurance, :float
  end
end
