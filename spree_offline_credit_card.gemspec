# encoding: UTF-8
Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'spree_offline_credit_card'
  s.version     = '2.2.0'
  s.summary     = ' offline credit card processing for spree 2.1'
  s.description = ' offline credit card processing spree 2.1'
  s.required_ruby_version = '>= 1.9.3'

  s.author    = 'Railsdog'
  s.email     = 'unknown'
 # s.homepage  = 'http://www.goodylabs.com'

  #s.files       = `git ls-files`.split("\n")
  #s.test_files  = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_path = 'lib'
  s.requirements << 'none'

  s.add_dependency 'spree_core'
  s.add_dependency 'luhn-ruby'
  s.add_dependency 'gpgme', '2.0.2'
  s.add_development_dependency 'capybara', '~> 2.1'
  s.add_development_dependency 'coffee-rails'
  s.add_development_dependency 'database_cleaner'
  s.add_development_dependency 'factory_girl', '~> 4.2'
  s.add_development_dependency 'ffaker'
  s.add_development_dependency 'rspec-rails',  '~> 2.13'
  s.add_development_dependency 'sass-rails'
  s.add_development_dependency 'selenium-webdriver'
  s.add_development_dependency 'simplecov'
  s.add_development_dependency 'sqlite3'
end