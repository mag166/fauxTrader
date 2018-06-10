class ChangeColumnName < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :total_deposit, :initial_deposit
  end
end
