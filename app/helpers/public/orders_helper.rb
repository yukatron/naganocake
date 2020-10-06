module Public::OrdersHelper
	def tax_added_currency(price, rate)
  		taxed_price = (price*rate).round
  		"#{taxed_price.to_s(:delimited, delimiter: ',')}"
  	end

  	def subtotal(price, rate, quantity)
  		taxed_price = (price*rate).round
  		subtotal = taxed_price*quantity
  		"#{subtotal.to_s(:delimited, delimiter: ',')}"
  	end

  	def sototal(price, quantity)
    subtotal = price * quantity
    "#{subtotal.to_s(:delimited, delimiter: ',')}"
  	end
end
