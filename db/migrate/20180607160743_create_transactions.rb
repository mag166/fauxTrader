class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.integer :user_id
      t.integer :company_id
      t.integer :shares
      t.float :price
      t.boolean :buy
      t.timestamps
    end
  end
end
