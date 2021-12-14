# frozen_string_literal: true

module WoW
  module DBC
    class Schema
      module Strings
        # @param name [Symbol]
        # @return [void]
        def string(name)
          raise ArgumentError, "#{self.name}##{name} is already defined" if method_defined?(name)

          field(:"#{name}_offset", :uint32)

          define_method(name) do
            @file.read_string(send(:"#{name}_offset"))
          end
        end

        # @param name [Symbol]
        # @param length [Integer]
        # @return [void]
        def string_array(name, length)
          raise ArgumentError, 'Array field length must be greater than 0' if length <= 0

          length.times do |index|
            string(:"#{name}#{index}")
          end

          define_method(name) do
            Array.new(length) { |index| send(:"#{name}#{index}") }
          end
        end
      end
    end
  end
end
