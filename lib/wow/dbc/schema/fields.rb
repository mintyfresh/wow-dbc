# frozen_string_literal: true

module WoW
  module DBC
    class Schema
      module Fields
        Field = Struct.new(:name, :format, :index)

        # @return [Array<Field>]
        def fields
          @fields ||= []
        end

        # @return [Array<Symbol>]
        def field_names
          fields.map(&:name)
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

          format = Format.lookup(format)
          index  = (@fields_count ||= 0)

          fields << Field.new(name.to_sym, format, index)
          @fields_count += 1

          define_method(name) { instance_variable_get(:"@#{name}") }
          define_method(:"#{name}=") { |value| instance_variable_set(:"@#{name}", format.cast(value)) }
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

          define_array_reader(name, length)
          define_array_writer(name, length)
        end

        Format::MAPPINGS.each_key do |format|
          define_method(format) { |name| field(name, format) }
          define_method(:"#{format}_array") { |name, length| array(name, format, length) }
        end

      private

        # @param name [Symbol]
        # @param length [Integer]
        # @return [void]
        def define_array_reader(name, length)
          define_method(name) do
            Array.new(length) { |index| send(:"#{name}#{index}") }
          end
        end

        # @param name [Symbol]
        # @param length [Integer]
        # @return [void]
        def define_array_writer(name, length)
          define_method(:"#{name}=") do |value|
            raise ArgumentError, 'Value must be an Array.' unless value.is_a?(Array)
            raise ArgumentError, "Value must have exactly #{length} elements" unless value.length == length

            value.each_with_index do |element, index|
              send(:"#{name}#{index}=", element)
            end
          end
        end
      end
    end
  end
end
