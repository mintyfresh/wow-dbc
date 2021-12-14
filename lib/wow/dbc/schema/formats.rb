# frozen_string_literal: true

module WoW
  module DBC
    class Schema
      FORMATS = {
        int32: lambda { |_, record, index|
          record.read_field(index, 'N')
        },
        uint32: lambda { |_, record, index|
          record.read_field(index, 'V')
        },
        float: lambda { |_, record, index|
          record.read_field(index, 'e')
        },
        string: lambda { |file, record, index|
          file.read_string(record.read_field(index, 'V'))
        }
      }.freeze
    end
  end
end
