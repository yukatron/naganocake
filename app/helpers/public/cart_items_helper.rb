module Public::CartItemsHelper

	def number_to_currency(price)
    	"#{price.to_s(:delimited, delimiter: ',')}円"
  	end

  	def tax_added_currency(price, rate)
  		taxed_price = (price*rate).round
  		"#{taxed_price}"
  	end


end
