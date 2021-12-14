# frozen_string_literal: true

module WoW
  module DBC
    class Schema
      module LocaleStrings
        # @param name [Symbol]
        # @return [void]
        def locale_string(name)
          raise ArgumentError, "#{self.name}##{name} is already defined" if method_defined?(name)

          enabled_locales.each do |locale|
            string(:"#{name}_#{locale}")
          end

          uint32(:"#{name}_flags") if include_flags?

          define_method(name) do
            send(:"#{name}_#{DBC.config.default_locale}")
          end
        end

      private

        # @return [Array<Symbol>]
        def enabled_locales
          locales = []

          # Everything prior to Cataclysm.
          if DBC.config.target_build <= 12340
            locales += %i[enUS koKR frFR deDE enCN enTW esES esMX]

            # Additional locales added in Patch 2.1.0.
            if DBC.config.target_build >= 6692
              locales += %i[ruRU jaJA ptPT itIT unknown12 unknown13 unknown14 unknown15]
            end
          else
            # Cataclysm drops all locales except client.
            locales << :client
          end

          locales
        end

        # @return [Boolean]
        def include_flags?
          # Cataclysm drops falgs.
          DBC.config.target_build <= 12340
        end
      end
    end
  end
end
