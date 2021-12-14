# frozen_string_literal: true

require_relative 'schema/formats'
require_relative 'schema/fields'
require_relative 'schema/locale_strings'

module WoW
  module DBC
    class Schema
      extend Fields
      extend LocaleStrings

      # @param file [WoW::DBC::File]
      # @param record [WoW::DBC::Record]
      # @return [Schema]
      def self.build_from_record(file, record)
        if record.fields_count != fields_count
          raise ArgumentError, "Record `fields_count` doesn't match schema " \
                               "(expected #{fields_count}, got #{record.fields_count})"
        end

        schema = new

        fields.each do |(name, format, index)|
          schema.send("#{name}=", FORMATS.fetch(format).call(file, record, index))
        end

        schema
      end

      # @return [Hash]
      def fields
        self.class.field_names.map { |name| [name, send(name)] }.to_h
      end
    end
  end
end
