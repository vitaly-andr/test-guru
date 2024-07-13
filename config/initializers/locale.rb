I18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}')]
I18n.available_locales = [:en, :ru]
I18n.default_locale = :ru

# Define pluralization rules for Russian
I18n.backend.store_translations(:ru, i18n: {
  plural: {
    keys: [:one, :few, :many, :other],
    rule: lambda { |n|
      if n % 10 == 1 && n % 100 != 11
        :one
      elsif [2, 3, 4].include?(n % 10) && ![12, 13, 14].include?(n % 100)
        :few
      elsif n % 10 == 0 || (5..9).include?(n % 10) || (11..14).include?(n % 100)
        :many
      else
        :other
      end
    }
  }
})
