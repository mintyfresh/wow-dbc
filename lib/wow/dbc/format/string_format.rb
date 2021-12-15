# frozen_string_literal: true

module WoW
  module DBC
    module Format
      class StringFormat
        # @param string_map [Hash{String => Integer}]
        # @param value [String, nil]
        # @return [String]
        def pack_to_file(string_map, value)
          [string_map.fetch(value || '')].pack('V')
        end

        # @param file [WoW::DBC::File]
        # @param record [WoW::DBC::Record]
        # @param index [Integer]
        # @return [String]
        def unpack_from_file(file, record, index)
          file.read_string(record.read_field(index, 'V'))
        end
      end
    end
  end
end
