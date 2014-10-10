Offline Creditcard
==================

This extension provides the ability to encrypt credit card information that is provided during checkout.  It also includes an offline gateway that gives you the option of storing the credit card without authorizing/capturing during checkout.

No decryption functionality is provided in this extension.  For totally secure storage of credit card information you should never store your private PGP key on a publicly accessible server.  This includes the server hosting your store.  There is an excellent Chrome plugin (Mailvelope) which provides a nice way to securely decrypt PGP encrypted information from a browser (where the client machine can hold the private key.)

Fork-specific Notes
-------------------
1. Updated to be compatible with Spree 2.2.0.beta
2. Slimmed down heavily. Now augments the payments screen to view encrypted data.
3. Uses native GPGME which must be installed on the server. (may switch to OpenPGP.js in the future)

Configuration
-------------
In the spree_offline_credit_card.rb initializer file, add:
<pre>
SpreeOfflineCreditCard::Config.public_key_email = "my_public_key_email@example.com"
SpreeOfflineCreditCard::Config.public_key_path = "config/my_public_key.asc"
SpreeOfflineCreditCard::Config.store_key_email = "my_store_key_email@example.com"
SpreeOfflineCreditCard::Config.store_public_private_key_path = "config/my_store_public_and_private_keys.asc"
</pre>
