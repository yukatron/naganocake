module Admin::ItemsHelper
	def number_to_currency(price)
    	"#{price.to_s(:delimited, delimiter: ',')}円"
  	end

  	def tax_added_currency(price, rate)
  		taxed_price = (price*rate).round
  		"#{taxed_price}円 (#{price}円)"
  	end


end
