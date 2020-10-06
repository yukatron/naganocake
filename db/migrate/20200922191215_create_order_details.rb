class CreateOrderDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :order_details do |t|
      t.integer :item_id, foreign_key: true
      t.integer :order_id, foreign_key: true
      t.integer :price
      t.integer :quantity
      t.integer :making_status, null: false, default: 0, limit: 1

      t.timestamps
    end
  end
end
