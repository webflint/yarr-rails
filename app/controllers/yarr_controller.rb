class YarrController < ActionController::Base
  def save
    params.each do |key, value|
      if i18n_valid? key
        translation = Translation.where(locale: locale, key:key).first
        translation ||= Translation.new locale: locale, key:key
        translation.value = value
        translation.save!

        I18n.config.backend.backends.each do |backend|
          backend.reload! if backend.is_a? I18n::Backend::ActiveRecord
        end
      end
    end
    head :ok
  end

  private def i18n_valid? key
    (I18n.t key, raise: true rescue false).present?
  end
end
