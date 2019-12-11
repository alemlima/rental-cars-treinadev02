class AddDisponibilityToCar < ActiveRecord::Migration[5.2]
  def change
    add_column :cars, :disponibility, :integer, default: 0
  end
end
