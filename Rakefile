require 'bundler/setup'
require 'em-synchrony/activerecord'

namespace :db do
  task :migrate do
    ActiveRecord::Base.establish_connection db_conf

    ActiveRecord::Migrator.migrate(
      ActiveRecord::Migrator.migrations_paths
    )
  end
end

def db_conf
  YAML.load File.read('config/database.yml')
end