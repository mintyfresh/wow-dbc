# frozen_string_literal: true

module WoW
  module DBC
    module Format
      class UInt32Format
        # @param string_map [Hash{String => Integer}]
        # @param value [String, nil]
        # @return [String]
        def pack_to_file(_, value)
          [value || 0].pack('V')
        end

        # @param file [WoW::DBC::File]
        # @param record [WoW::DBC::Record]
        # @param index [Integer]
        # @return [Integer]
        def unpack_from_file(_, record, index)
          record.read_field(index, 'V')
        end
      end
    end
  end
end
