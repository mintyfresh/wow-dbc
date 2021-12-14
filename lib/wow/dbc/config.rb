# frozen_string_literal: true

module WoW
  module DBC
    class Config
      # @return [Integer]
      attr_accessor :target_build
      # @return [Symbol]
      attr_accessor :default_locale

      def initialize
        @target_build   = 12340 # rubocop:disable Style/NumericLiterals
        @default_locale = :enUS
      end
    end
  end
end
