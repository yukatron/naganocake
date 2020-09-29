module Public::ItemsHelper
	def number_to_currency(price)
    	"¥#{price.to_s(:delimited, delimiter: ',')}"
  	end

  	def tax_added_currency(price, rate)
  		taxed_price = (price*rate).round
  		"#{taxed_price}"
  	end
end
