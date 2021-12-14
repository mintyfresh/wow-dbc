# frozen_string_literal: true

require_relative 'dbc/config'
require_relative 'dbc/file'
require_relative 'dbc/format_error'
require_relative 'dbc/header'
require_relative 'dbc/magic'
require_relative 'dbc/reader'
require_relative 'dbc/record'
require_relative 'dbc/schema'
require_relative 'dbc/version'

module WoW
  module DBC
    # @return [Config]
    def self.config
      @config ||= Config.new
    end

    # @return [void]
    def self.configure
      config = Config.new
      yield(config)

      @config = config
    end

    # @param file [::File, String, Pathname]
    # @return [WoW::DBC::File]
    def self.read_file(file)
      file = ::File.open(file, 'rb') if file.is_a?(String) || file.is_a?(Pathname)

      Reader.new(file).read_file
    end

    # @param file [::File, String, Pathname]
    # @param schema [Class<WoW::DBC::Schema>]
    # @return [Enumerable<Wow::DBC::Schema>]
    def self.read_records(file, schema)
      file = read_file(file)

      file.records.lazy.map do |record|
        schema.new(file, record)
      end
    end
  end
end
