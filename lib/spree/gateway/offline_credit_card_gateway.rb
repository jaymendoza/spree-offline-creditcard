# Offline gateway that always succeeds in capturing or authorizing the order.  Orders should then be manually 
# authorized/captured or done so by a seperate automated process.

module Spree #:nodoc:
  class Gateway::OfflineCreditCardGateway < Gateway
    require 'luhn'
    def provider_class
      self.class
    end

    def payment_source_class
      CreditCard
    end

    def preferences
      {}
    end
    
    def payment_profiles_supported?
      true
    end

    def authorize(money, credit_card, options = {})
      if credit_card.gateway_customer_profile_id =~ /^BGS/
        ActiveMerchant::Billing::Response.new(true, 'Offline Credit Card Gateway: Forced success', {}, :test => !(Rails.env == 'production'), :authorization => '12345', :avs_result => { :code => 'A' })
      else
        ActiveMerchant::Billing::Response.new(false, 'Offline Credit Card Gateway: Forced failure', { :message => "Unfortunately, we were unable to process the credit card number you provided.  Please check the number and try again." }, :test => !(Rails.env == 'production'))
      end
    end

    # def purchase(money, credit_card, options = {})
    #   ActiveMerchant::Billing::Response.new(true, "Offline Gateway: Forced success", {})
    # end 

    def credit(money, credit_card, response_code, options = {})
      ActiveMerchant::Billing::Response.new(true, "Offline Gateway: Forced success", {})
    end
 
    def capture(authorization, credit_card, gateway_options)
      ActiveMerchant::Billing::Response.new(true, "Offline Gateway: Forced success", {})
    end
    
    def void(response_code, credit_card, options = {})
      ActiveMerchant::Billing::Response.new(true, "Offline Gateway: Forced success", {})
    end

    def actions
      %w(authorize capture void credit)
    end

    def create_profile(payment)
      # simulate the storage of credit card profile using remote service
      successful = Luhn.valid?(payment.source.number)
      message = "Unfortunately, we were unable to process the credit card number you provided.  Please check the number and try again."
      payment.source.update_attributes(:gateway_customer_profile_id => generate_profile_id(successful))

      # ActiveMerchant::Billing::Response.new(successful, message,
      #   :test => false, #!(Rails.env == 'production'),
      #   :authorization => '12345',
      #   :cvv_result => 'P', # P is not processed
      #   :avs_result => 'S'  # S is system unavailable
      # )               
      if successful
        payment.source.update_attributes(:gateway_customer_profile_id => generate_profile_id(successful))
        # creditcard.update_attributes(:gateway_customer_profile_id => result.params['customerCode'], :gateway_payment_profile_id => result.params['customer_vault_id'])
      else
        payment.send(:gateway_error, message)
      end
    end

    private
    def generate_profile_id(success)
      already_existing_record = true
      prefix = success ? 'BGS' : 'FAIL'
      while already_existing_record
        random = "#{prefix}-#{Array.new(6){rand(6)}.join}"
        already_existing_record = !CreditCard.find_by(gateway_customer_profile_id: random).blank?
      end
      random
    end

  end
end


# module Spree
#   class Gateway::Bogus < Gateway
#     TEST_VISA = ['4111111111111111','4012888888881881','4222222222222']
#     TEST_MC = ['5500000000000004','5555555555554444','5105105105105100']
#     TEST_AMEX = ['378282246310005','371449635398431','378734493671000','340000000000009']
#     TEST_DISC = ['6011000000000004','6011111111111117','6011000990139424']

#     VALID_CCS = ['1', TEST_VISA, TEST_MC, TEST_AMEX, TEST_DISC].flatten

#     attr_accessor :test

#     def provider_class
#       self.class
#     end

#     def preferences
#       {}
#     end

#     def create_profile(payment)
#       # simulate the storage of credit card profile using remote service
#       success = VALID_CCS.include? payment.source.number
#       payment.source.update_attributes(:gateway_customer_profile_id => generate_profile_id(success))
#     end

#     def authorize(money, credit_card, options = {})
#       profile_id = credit_card.gateway_customer_profile_id
#       if VALID_CCS.include? credit_card.number or (profile_id and profile_id.starts_with? 'BGS-')
#         ActiveMerchant::Billing::Response.new(true, 'Bogus Gateway: Forced success', {}, :test => true, :authorization => '12345', :avs_result => { :code => 'A' })
#       else
#         ActiveMerchant::Billing::Response.new(false, 'Bogus Gateway: Forced failure', { :message => 'Bogus Gateway: Forced failure' }, :test => true)
#       end
#     end

#     def purchase(money, credit_card, options = {})
#       profile_id = credit_card.gateway_customer_profile_id
#       if VALID_CCS.include? credit_card.number or (profile_id and profile_id.starts_with? 'BGS-')
#         ActiveMerchant::Billing::Response.new(true, 'Bogus Gateway: Forced success', {}, :test => true, :authorization => '12345', :avs_result => { :code => 'A' })
#       else
#         ActiveMerchant::Billing::Response.new(false, 'Bogus Gateway: Forced failure', :message => 'Bogus Gateway: Forced failure', :test => true)
#       end
#     end

#     def credit(money, credit_card, response_code, options = {})
#       ActiveMerchant::Billing::Response.new(true, 'Bogus Gateway: Forced success', {}, :test => true, :authorization => '12345')
#     end

#     def capture(authorization, credit_card, gateway_options)
#       if authorization.response_code == '12345'
#         ActiveMerchant::Billing::Response.new(true, 'Bogus Gateway: Forced success', {}, :test => true, :authorization => '67890')
#       else
#         ActiveMerchant::Billing::Response.new(false, 'Bogus Gateway: Forced failure', :error => 'Bogus Gateway: Forced failure', :test => true)
#       end

#     end

#     def void(response_code, credit_card, options = {})
#       ActiveMerchant::Billing::Response.new(true, 'Bogus Gateway: Forced success', {}, :test => true, :authorization => '12345')
#     end

#     def test?
#       # Test mode is not really relevant with bogus gateway (no such thing as live server)
#       true
#     end

#     def payment_profiles_supported?
#       true
#     end

#     def actions
#       %w(capture void credit)
#     end

#     private
#       def generate_profile_id(success)
#         record = true
#         prefix = success ? 'BGS' : 'FAIL'
#         while record
#           random = "#{prefix}-#{Array.new(6){rand(6)}.join}"
#           record = Credit_Card.where(:gateway_customer_profile_id => random).first
#         end
#         random
#       end
#   end
# end