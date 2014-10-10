class AddOfflineGateway < ActiveRecord::Migration
  def up
    gateway = Spree::PaymentMethod.create!(
      {
        :type => "Spree::Gateway::OfflineCreditCardGateway",
        :name => "Credit Card",
        :description => "Offline Credit Card Processing Gateway",
        :environment => "production",
        :active => true
      }
    )
    gateway = Spree::PaymentMethod.create!(
      {
        :type => "Spree::Gateway::OfflineCreditCardGateway",
        :name => "Credit Card",
        :description => "Offline Credit Card Processing Gateway",
        :environment => "development",
        :active => true
      }
    )
    gateway = Spree::PaymentMethod.create!(
      {
        :type => "Spree::Gateway::OfflineCreditCardGateway",
        :name => "Credit Card",
        :description => "Offline Credit Card Processing Gateway",
        :environment => "test",
        :active => true
      }
    )
  end

  def down
    Spree::Gateway::OfflineCreditCardGateway.delete_all
  end
end