# frozen_string_literal: true

module WoW
  module DBC
    Header = Struct.new(:records_count, :fields_count, :record_size, :string_block_size)
  end
end
