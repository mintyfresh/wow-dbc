# frozen_string_literal: true

module WoW
  module DBC
    class Schema
      FORMATS = {
        int32: 'N',
        uint32: 'V',
        float: 'e'
      }.freeze
    end
  end
end
