source 'https://rubygems.org'



group :test do
  gem 'sass-rails',   '~> 3.2.5'
  gem 'coffee-rails', '~> 3.2.1'

  if RUBY_PLATFORM.downcase.include? "darwin"
    gem 'rb-fsevent'
    gem 'growl'
    gem 'guard-rspec'
  end
end

# gem 'devise'
# # gem 'spree_auth_devise',      github: 'spree/spree_auth_devise',      branch: '2-0-stable'
# gem 'devise-encryptable'

# gem 'spree',                  github: 'spree/spree'#,                  branch: '2-2-stable'
# # gem 'spree_i18n', :git => 'git://github.com/spree/spree_i18n.git', branch: '2-0-stable'


gem 'spree_auth_devise', github: 'spree/spree_auth_devise'

gemspec