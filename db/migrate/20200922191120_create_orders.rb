class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.integer :customer_id, foreign_key: true
      t.string :postal_code
      t.string :address
      t.string :name
      t.integer :shipping_cost
      t.integer :total_payment
      t.integer :payment_method, null: :false, limit: 1
      t.integer :status, null: :false, default: 0, limit: 1

      t.timestamps
    end
  end
end
