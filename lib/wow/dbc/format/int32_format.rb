# frozen_string_literal: true

module WoW
  module DBC
    module Format
      class Int32Format
        MIN_VALUE = -(2**31)
        MAX_VALUE = +(2**31) - 1

        # @param value [String, Numeric, nil]
        # @return [Integer, nil]
        def cast(value)
          return if value.nil?

          value = value.to_i
          raise ArgumentError, "Int32 value cannot be less than #{MIN_VALUE}" if value < MIN_VALUE
          raise ArgumentError, "Int32 value cannot be greater than #{MAX_VALUE}" if value > MAX_VALUE

          value
        end

        # @param string_map [Hash{String => Integer}]
        # @param value [Integer, nil]
        # @return [String]
        def pack_to_file(_, value)
          [value || 0].pack('N')
        end

        # @param file [WoW::DBC::File]
        # @param record [WoW::DBC::Record]
        # @param index [Integer]
        # @return [Integer]
        def unpack_from_file(_, record, index)
          record.read_field(index, 'N')
        end
      end
    end
  end
end
