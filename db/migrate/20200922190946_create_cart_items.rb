class CreateCartItems < ActiveRecord::Migration[5.2]
  def change
    create_table :cart_items do |t|
      t.integer :customer_id, foreign_key: true
      t.integer :item_id, foreign_key: true
      t.integer :quantity

      t.timestamps
    end
  end
end
