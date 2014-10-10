require 'spree_core'
require 'spree_offline_credit_card/engine'
# require 'spree_offline_credit_card/version'
# class MyTest
# end
# class MyTest::Configuration < Spree::Preferences::Configuration
# preference :test_field, :string, :default => 'this is a test field'
# end
# debugger
# a = 1

# require 'spree/offline_credit_card_configuration'


# require 'spree_core'

# module Spree
#   module OfflineCreditCard
#     class Engine < Rails::Engine
#       engine_name 'spree_offline_creditcard'
      
#       initializer "spree.advanced_cart.environment", :before => :load_config_initializers do |app|
#         Spree::OfflineCreditCard::Config = Spree::OfflineCreditCardConfiguration.new
#       end
      
#       config.autoload_paths += %W(#{config.root}/lib)

#       # def self.activate
#       #   Dir.glob(File.join(File.dirname(__FILE__), "../app/**/spree/*_decorator*.rb")) do |c|
#       #     Rails.application.config.cache_classes ? require(c) : load(c)
#       #   end
#       #   Spree::Ability.register_ability(Spree::AddressAbility)
#       # end

#       def self.activate    
#         # credit card numbers should always be stored in the case of offline processing (no other option makes sense)
#         # Spree::Config.set(:store_cc => true) 
        
#         Creditcard.class_eval do 
#           require 'openssl'
#           require 'base64'
          
#           # overrides filter_sensitive to make sure the stored values are encrypted.
#           private
#           def filter_sensitive                 
#             # don't encrypt again, this way we can clone and order and its creditcard and keep text encrypted
#             return unless encrypted_text.blank?
#             gnupg = GnuPG.new :recipient => Spree::Pgp::Config[:email]
#             public_key_text = Rails.cache.fetch('public_key') do
#               File.read("#{RAILS_ROOT}/#{Spree::Pgp::Config[:public_key]}")
#             end
#             gnupg.load_public_key public_key_text        
#             text = "Number: #{number}    Code: #{verification_value}"
#             self[:encrypted_text] = gnupg.encrypt(text)
#             self[:display_number] = ActiveMerchant::Billing::CreditCard.mask(number) if self.display_number.blank?
#             self[:number] = ""
#             self[:verification_value] = ""
#           end
#         end

#         # register Creditcards tab
#         Admin::BaseController.class_eval do
#           before_filter :add_creditcard_tab
#           private

#           def add_creditcard_tab
#             @order_admin_tabs ||= []
#             @order_admin_tabs << {:name => t('credit_card_payment'), :url => "admin_order_creditcard_payments_url"}
#           end
#         end
#       end


#       config.to_prepare &method(:activate).to_proc
#     end
#   end
# end