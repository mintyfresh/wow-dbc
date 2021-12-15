# frozen_string_literal: true

require_relative 'schema/fields'
require_relative 'schema/locale_strings'

module WoW
  module DBC
    class Schema
      extend Fields
      extend LocaleStrings

      # @return [Integer]
      def self.record_size
        fields_count * 4 # TODO: Compute precise record size.
      end

      # @param file [WoW::DBC::File]
      # @param record [WoW::DBC::Record]
      # @return [Schema]
      def self.build_from_record(file, record)
        if record.fields_count != fields_count
          raise ArgumentError, "Record `fields_count` doesn't match schema " \
                               "(expected #{fields_count}, got #{record.fields_count})"
        end

        schema = new

        fields.each do |field|
          schema.send("#{field.name}=", field.format.unpack_from_file(file, record, field.index))
        end

        schema
      end

      # @param format [Symbol, nil]
      # @return [Hash]
      def fields(format: nil)
        fields = self.class.fields

        if format
          format = Format.lookup(format) if format.is_a?(Symbol)
          fields = fields.select { |field| field.format == format }
        end

        fields.map { |field| [field.name, send(field.name)] }.to_h
      end
    end
  end
end
