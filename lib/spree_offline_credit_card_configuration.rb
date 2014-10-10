class SpreeOfflineCreditCardConfiguration < Spree::Preferences::Configuration
  # preference :disable_bill_address, :boolean, :default => false
  preference :public_key_email, :string, :default => "foo@example.com" # replace with address of your PGP key
  
  preference :public_key_path, :string, :default => "config/foo-public.asc" # replace with real location of PUBLIC key

  preference :store_key_email , :string, :default => 'store@example.com' # replace with store's email address from it's PGP key
  
  preference :store_public_private_key_path , :string, :default => 'config/foo-public.asc' # path to store public and private keys
end
