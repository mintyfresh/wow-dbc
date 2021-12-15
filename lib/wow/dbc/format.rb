# frozen_string_literal: true

require_relative 'format/float_format'
require_relative 'format/int32_format'
require_relative 'format/string_format'
require_relative 'format/uint32_format'

module WoW
  module DBC
    module Format
      MAPPINGS = {
        float: FloatFormat.new,
        int32: Int32Format.new,
        string: StringFormat.new,
        uint32: UInt32Format.new
      }.freeze

      # @param locator [Symbol]
      def self.lookup(locator)
        MAPPINGS.fetch(locator) do
          raise ArgumentError, "Unknown format type: #{locator}"
        end
      end
    end
  end
end
