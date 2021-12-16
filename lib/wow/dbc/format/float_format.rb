# frozen_string_literal: true

module WoW
  module DBC
    module Format
      class FloatFormat
        # @param value [String, Numeric, nil]
        # @return [Float, nil]
        def cast(value)
          value&.to_f
        end

        # @param string_map [Hash{String => Integer}]
        # @param value [Float, nil]
        # @return [String]
        def pack_to_file(_, value)
          [value || 0.0].pack('e')
        end

        # @param file [WoW::DBC::File]
        # @param record [WoW::DBC::Record]
        # @param index [Integer]
        # @return [Float]
        def unpack_from_file(_, record, index)
          record.read_field(index, 'e')
        end
      end
    end
  end
end
