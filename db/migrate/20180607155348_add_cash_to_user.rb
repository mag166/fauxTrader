class AddCashToUser < ActiveRecord::Migration[5.2]
  def change
    change_table :users do |t|
      t.float :cash
      t.float :total_deposit
    end
  end
end
