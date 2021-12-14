# frozen_string_literal: true

module WoW
  module DBC
    class Schema
      module Fields
        # @return [Array<Symbol>]
        def fields
          @fields ||= []
        end

        # @return [Integer]
        def fields_count
          fields.length
        end

        # @param name [Symbol]
        # @param format [Symbol]
        # @return [void]
        def field(name, format)
          raise ArgumentError, "#{self.name}##{name} is already defined" if method_defined?(name)
          raise ArgumentError, "Unsupported field format: #{format}" unless FORMATS.key?(format)

          fields << [name, format]

          define_method(name) do
            @record.read_field(name, FORMATS.fetch(format))
          end
        end

        # @param name [Symbol]
        # @param format [Symbol]
        # @param length [Integer]
        # @return [void]
        def array(name, format, length)
          raise ArgumentError, 'Array field length must be greater than 0' if length <= 0

          length.times do |index|
            field(:"#{name}#{index}", format)
          end

          define_method(name) do
            Array.new(length) { |index| send(:"#{name}#{index}") }
          end
        end

        FORMATS.each_key do |format|
          define_method(format) { |name| field(name, format) }
          define_method(:"#{format}_array") { |name, length| array(name, format, length) }
        end
      end
    end
  end
end