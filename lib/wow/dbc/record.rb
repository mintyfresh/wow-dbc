# frozen_string_literal: true

module WoW
  module DBC
    class Record
      # @return [Integer]
      attr_reader :record_size
      # @return [Integer]
      attr_reader :fields_count
      # @return [String]
      attr_reader :record_data

      # @param record_size [Integer]
      # @param fields_count [Integer]
      # @param record_data [String]
      def initialize(record_size, fields_count, record_data)
        @record_size  = record_size
        @fields_count = fields_count
        @record_data  = record_data
      end

      # @return [Integer]
      def field_size
        record_size / fields_count
      end

      # @param index [Integer]
      # @param format [String]
      # @return [Numeric, Boolean]
      def read_field(index, format)
        if index.negative? || index >= fields_count
          raise ArgumentError, "Index #{index} out of record bounds [0, #{fields_count})"
        end

        record_data[index * field_size, field_size].unpack1(format)
      end

      # @return [String]
      def to_s
        "#<#{self.class.name} record_size=#{record_size} " \
          "fields_count=#{fields_count} record_data=[#{record_data.bytesize} bytes]>"
      end

      alias inspect to_s
    end
  end
end
