# frozen_string_literal: true

module WoW
  module DBC
    class Reader
      # @param file [::File]
      def initialize(file)
        @file = file
      end

      # @return [WoW::DBC::File]
      def read_file
        @header  = read_header
        @records = read_records
        @strings = read_strings

        File.new(@header, @records, @strings)
      end

    private

      # @return [Header]
      def read_header
        raise FormatError, 'File is missing WDBC header' if @file.read(4) != MAGIC

        # Header contains 4 fields, each of which is 4 bytes long.
        Header.new(*@file.read(4 * 4).unpack('V4'))
      end

      # @return [Array<Record>]
      def read_records
        Array.new(@header.records_count) do
          Record.new(
            @header.record_size,
            @header.fields_count,
            @file.read(@header.record_size)
          )
        end
      end

      # @return [String]
      def read_strings
        @file.read(@header.string_block_size)
      end
    end
  end
end
