module Admin::OrdersHelper
	def sototal(price, quantity)
    subtotal = price * quantity
    "#{subtotal.to_s(:delimited, delimiter: ',')}"
  	end
end
