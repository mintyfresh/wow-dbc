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
  end
end
