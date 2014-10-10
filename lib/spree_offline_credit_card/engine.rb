module SpreeOfflineCreditCard
  class Engine < Rails::Engine
    require 'spree/core'
    # isolate_namespace Spree
    engine_name 'spree_offline_credit_card'

    config.autoload_paths += %W(#{config.root}/lib)

    # use rspec for tests
    config.generators do |g|
      g.test_framework :rspec
    end

    # def self.activate
    #   Dir.glob(File.join(File.dirname(__FILE__), '../../app/**/*_decorator*.rb')) do |c|
    #     Rails.configuration.cache_classes ? require(c) : load(c)
    #   end
    # end

    initializer "spree.gateway.payment_methods", :after => "spree.register.payment_methods" do |app|
      app.config.spree.payment_methods << Spree::Gateway::OfflineCreditCardGateway
    end

    # initializer "spree.offline_credit_card.preferences", :after => "spree.environment" do |app|
    #   SpreeOfflineCreditCard::Config = SpreeOfflineCreditCardConfiguration.new
    # end

    def self.activate    

      Dir.glob(File.join(File.dirname(__FILE__), "../../app/**/*_decorator*.rb")) do |c|
        Rails.configuration.cache_classes ? require(c) : load(c)
      end
      # credit card numbers should always be stored in the case of offline processing (no other option makes sense)
      # Spree::Config.set(:store_cc => true) 
    end


    config.to_prepare &method(:activate).to_proc
  end
end
