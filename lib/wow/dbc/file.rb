# frozen_string_literal: true

module WoW
  module DBC
    class File
      # @return [Header]
      attr_reader :header
      # @return [Array<Record>]
      attr_reader :records
      # @return [String]
      attr_reader :strings

      # @param header [Header]
      # @param records [Array<Record>]
      # @param strings [String]
      def initialize(header, records, strings)
        @header  = header
        @records = records
        @strings = strings
      end

      # @param offset [Integer]
      # @return [String]
      def read_string(offset)
        strings[offset..].split("\0", 2)[0]
      end

      # @return [String]
      def to_s
        "#<#{self.class} header=#{header} records=[#{records.length} records] strings=[#{strings.bytesize} bytes]>"
      end

      alias inspect to_s
    end
  end
end
