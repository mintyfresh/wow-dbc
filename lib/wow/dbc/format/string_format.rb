# frozen_string_literal: true

module WoW
  module DBC
    module Format
      class StringFormat
        # 32-bit unsigned, little-endian
        FORMAT = 'L<'

        # @param value [Object, nil]
        # @return [String, nil]
        def cast(value)
          value&.to_s
        end

        # @param string_map [Hash{String => Integer}]
        # @param value [String, nil]
        # @return [String]
        def pack_to_file(string_map, value)
          [string_map.fetch(value || '')].pack(FORMAT)
        end

        # @param file [WoW::DBC::File]
        # @param record [WoW::DBC::Record]
        # @param index [Integer]
        # @return [String]
        def unpack_from_file(file, record, index)
          file.read_string(record.read_field(index, FORMAT))
        end
      end
    end
  end
end
