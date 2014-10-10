module Spree
  Payment.class_eval do 
  	# def failure # method called when processing fails.
  	# 	# change state pack to pre-payment
  	# 	order.state = :payment
  	# 	order.save!
  	# end
  end
end