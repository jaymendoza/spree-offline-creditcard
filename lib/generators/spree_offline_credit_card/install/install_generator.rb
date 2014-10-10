module SpreeOfflineCreditCard
  module Generators
    class InstallGenerator < Rails::Generators::Base

      class_option :auto_run_migrations, :type => :boolean, :default => false
      source_root File.expand_path("../../templates", __FILE__)

      def add_javascripts
        # append_file 'app/assets/javascripts/store/all.js', "//= require store/spree_address_book\n"
        # append_file 'app/assets/javascripts/admin/all.js', "//= require admin/spree_address_book\n"
      end

      def add_stylesheets
        # inject_into_file 'app/assets/stylesheets/store/all.css', " *= require store/spree_address_book\n", :before => /\*\//, :verbose => true
        # inject_into_file 'app/assets/stylesheets/admin/all.css', " *= require admin/spree_address_book\n", :before => /\*\//, :verbose => true
      end

      def copy_initializer
        template 'initializer_for_offline_credit_card.rb', 'config/initializers/spree_offline_credit_card.rb'
      end

      def add_migrations
        run 'rake railties:install:migrations FROM=spree_offline_credit_card'
      end

      def run_migrations
        run_migrations = options[:auto_run_migrations] || ['', 'y', 'Y'].include?(ask 'Would you like to run the migrations now? [Y/n]')
        if run_migrations
          run 'rake db:migrate'
        else
          puts 'Skipping rake db:migrate, don\'t forget to run it!'
        end
      end
    end
  end
end
