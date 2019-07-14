require_relative 'boot'

require 'rails/all'
# require 'devise'    # Bundler.requireよりも上にこの記述を入れてuninitialized constant Devise (NameError)を回避

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ChatSpace
  class Application < Rails::Application
    # submitボタンを2回目以降も押せるようにする記述
    config.action_view.automatically_disable_submit_tag = false # data-disable-withを無効にする

    # 表示をUST→JSTに変更する
    config.time_zone = 'Tokyo'
    # DBの保存時間を変更する
    config.active_record.default_timezone = :local
    config.active_record.time_zone_aware_attributes = :false

    config.generators do |g|
      g.stylesheets false
      g.javascripts false
      g.helper false
      g.test_framework false
    end
    config.i18n.default_locale = :ja
  end
end
