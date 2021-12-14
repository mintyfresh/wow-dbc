# frozen_string_literal: true

require_relative 'schema/formats'
require_relative 'schema/fields'
require_relative 'schema/strings'
require_relative 'schema/locale_strings'

module WoW
  module DBC
    class Schema
      extend Fields
      extend Strings
      extend LocaleStrings

      # @return [WoW::DBC::File]
      attr_reader :file
      # @return [WoW::DBC::Record]
      attr_reader :record

      # @param file [WoW::DBC::File]
      # @param record [WoW::DBC::Record]
      def initialize(file, record)
        if record.fields_count != self.class.fields_count
          raise ArgumentError, "Record `fields_count` doesn't match schema " \
                               "(expected #{self.class.fields_count}, got #{record.fields_count})"
        end

        @file   = file
        @record = record
      end
    end
  end
end
