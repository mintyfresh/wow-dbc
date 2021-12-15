# frozen_string_literal: true

require 'stringio'

module WoW
  module DBC
    class Writer
      # @param file [::File]
      def initialize(file)
        @file = file
      end

      # @param records [Array<Schema>]
      # @return [void]
      def write_file(records)
        raise ArgumentError, 'Cannot write empty record set' if records.none?
        raise ArgumentError, 'Cannot write records of multiple types' if records.group_by(&:class).count > 1

        @strings, @string_map = generate_string_block(records)

        write_header(records)
        write_records(records)
        write_strings(records)
      end

    private

      # @param records [Array<Schema>]
      # @return [void]
      def write_header(records)
        @file.write(MAGIC)
        @file.write([
          records.count,
          records.first.class.fields_count,
          records.first.class.record_size,
          @strings.bytesize
        ].pack('V4'))
      end

      # @param records [Array<Schema>]
      # @return [void]
      def write_records(records)
        records.each do |record|
          record.class.fields.each do |field|
            @file.write(field.format.pack_to_file(@string_map, record.send(field.name)))
          end
        end
      end

      # @param records [Array<Schema>]
      # @return [void]
      def write_strings(_records)
        @file.write(@strings)
      end

      # @param records [Array<Schema>]
      # @return [Array]
      def generate_string_block(records)
        strings    = "\0".dup
        string_map = { '' => 0 }

        records.each do |record|
          record.fields(format: :string).each_value do |value|
            next if string_map.key?(value || '')

            string_map[value] = strings.size
            strings << "#{value}\0"
          end
        end

        [strings, string_map]
      end
    end
  end
end
