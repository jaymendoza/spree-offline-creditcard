class AddPgpEncryptedText < ActiveRecord::Migration
  def up
    add_column :spree_credit_cards, :encrypted_text, :text
  end

  def down
    remove_column :spree_credit_cards, :encrypted_text
  end
end