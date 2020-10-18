require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module InstaClone
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # generatorsコマンド時の自動生成を防ぎたいファイルを以下に記載
    config.generators do |g|
      # css,jsのファイルは作成せず
      g.assets false
      # コントローラー作成時にconfig/routes.rbが書き換えられないようにする。
      g.skip_routes false
      # テストファイルは作成せず
      g.test_framework false
    end

    # TimeWithZoneオブジェクトにする際にTokyoのオブジェクトにする。
    config.time_zone = 'Tokyo'
    # DBに保存する時間もJSTにする。(海外ユーザー等も使用する想定なら記載しない方が良い)
    config.active_record.default_timezone = :local

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
