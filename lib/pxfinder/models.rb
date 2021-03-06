require 'sequel'

# TODO: fix this mess
module Pxfinder
  module Models
    def self.included(_)
      init if @db.nil?
      load_models unless @models_loaded
    end

    def self.init
      connect
      init_sequel_model_plugins

      # migrate database
      migrating_dir = File.join(File.dirname(__FILE__), '../../db/migrations')
      Sequel::Migrator.apply(@db, migrating_dir)

      freeze_db if ENV['RACK_ENV'] != 'development'
    end

    def self.connect
      # init global db extensions
      Sequel.extension(:migration)

      @db = Sequel.connect(configatron.db_url)

      # init db instance extensions
      @db.extension(:connection_validator)
      @db.extension(:pg_json)
      @db.extension(:freeze_datasets)

      @db.pool.connection_validation_timeout = -1
      # @db.loggers << $log

      return unless ENV['RACK_ENV'] == 'development'

      Sequel::Model.cache_associations = false
    end

    def self.init_sequel_model_plugins
      Sequel::Model.plugin(:validation_helpers)
      Sequel::Model.plugin(:auto_validations)
      Sequel::Model.plugin(:prepared_statements)
      Sequel::Model.plugin(:timestamps, update_on_create: true)
      Sequel::Model.plugin(:json_serializer)
      Sequel::Model.plugin(:subclasses) if ENV['RACK_ENV'] != 'development'
    end

    def self.freeze_db
      Sequel::Model.freeze_descendents
      @db.freeze
    end

    def self.load_models
      require 'pxfinder/models/camera'
      require 'pxfinder/models/creator'
      require 'pxfinder/models/lens'
      require 'pxfinder/models/manufacturer'
      require 'pxfinder/models/photo'
      require 'pxfinder/models/sensor_type'
    end
  end
end
