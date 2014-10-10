SpreeOfflineCreditCard::Config = SpreeOfflineCreditCardConfiguration.new

# # email address associated with your public key
SpreeOfflineCreditCard::Config.public_key_email = 'my_public_key_email@example.com'

# path to your public key. e.g. 'config/my_public_key.asc'
SpreeOfflineCreditCard::Config.public_key_path = 'config/my_public_key.asc'

# email address associated with your store's key. e.g. 'my_store_key_email@example.com'
SpreeOfflineCreditCard::Config.store_key_email = 'my_store_key_email@example.com'

# path to your store's key file which contains the public and private keys. e.g. 'config/store_public_and_private_key.asc'
SpreeOfflineCreditCard::Config.store_public_private_key_path = 'config/store_public_and_private_key.asc'