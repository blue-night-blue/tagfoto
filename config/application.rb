require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Tagfoto
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    
    #ここから俺の。
    
    # デフォルトのロケールを:en以外に変更する
    config.i18n.default_locale = :ja
   
    # 複数画像を別レコードとして保存する際に、multiple:trueで勝手に空白列を入れるのを阻止
    config.active_storage.multiple_file_field_include_hidden = false

    # 画像アップの上限撤廃
    Rack::Utils.multipart_part_limit = 0
    
    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
  end
end
