# frozen_string_literal: true

# The `validates_email_format_of` gem includes `pt-BR.yml`, which adds `:pt-BR`
# to `I18n.available_locales`. Translatewiki and the Dashboard use `:pt-br`
# (and `:pt`). Removing this file from `I18n.load_path` prevents the duplicate
# and incomplete `pt-BR` locale from appearing in the language selector or
# backend locales.
#
# The gem re-adds its locale files every time `load_i18n_locales` is called,
# so the file is removed again after each call, not just once at boot.
module ValidatesEmailFormatOf
  module ExcludePtBrLocale
    def load_i18n_locales
      super
      I18n.load_path.reject! { |path| File.basename(path) == 'pt-BR.yml' }
    end
  end

  singleton_class.prepend(ExcludePtBrLocale)
end

I18n.load_path.reject! { |path| File.basename(path) == 'pt-BR.yml' }
