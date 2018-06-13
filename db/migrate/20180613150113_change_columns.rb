class ChangeColumns < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :cash, :float, :default => 10000
    change_column :users, :initial_deposit, :float, :default => 10000
  end
end
