I18n.config.available_locales = %i(en ja)
if Rails.env.test?
  I18n.default_locale = :en
else
  I18n.default_locale = :ja
end