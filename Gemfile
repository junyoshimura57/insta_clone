source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.4'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.3'
# Use mysql as the database for Active Record
gem 'mysql2', '>= 0.4.4', '< 0.6.0'
# Use Puma as the app server
gem 'puma', '~> 3.11'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'mini_racer', platforms: :ruby

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use ActiveStorage variant
# mini_magickを使用するためコメントアウトを解除
gem 'mini_magick', '~> 4.8'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Railsのジェネレーターでもslimを使うため追加
gem 'slim-rails'
# layoutファイルのerbを自動修正させるため追加
gem 'html2slim'
# redisを使用するために追加
gem 'redis-rails'

# sorceryを使用するため追加
gem 'sorcery'

# jquery、popper_jsがないとエラーが出たため追加。(yarnで入れたものを活かすには、マニュフェストファイルの内容をdist/jquery.jsに変更要？？)
gem 'jquery-rails'
gem 'popper_js'

# エラー文言を日本語で出すために追加
gem 'rails-i18n'

# Carrierwaveを使用するため追加
gem 'carrierwave'

# CarrierWaveのエラーを日本語化させるため追加
gem 'carrierwave-i18n'

# ページネーションを導入するために追加
gem 'kaminari'

gem 'sidekiq'

# sidekiqのダッシュボードを利用するために、sinatraをいれる。
gem 'sinatra'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  # fakerを使用するためgemを追加
  gem 'faker'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'

  # エラーの画面にリクエスト情報、ローカル変数情報を出すために追加
  gem 'better_errors'
  # 上記エラー画面にirbをつけるために追加
  gem 'binding_of_caller'

  # pryでデバッグをするために追加(irbに比べてシンタックスハイライトが効くなどメリットがあるらしい)
  gem 'pry-rails'
  # pryでstepなどのデバックコマンドを使えるようになる。
  gem 'pry-byebug'

  # 各モデルにカラム情報を出したり、config/routes.rbにルーティング情報を書き出してくれる。(便利！！)
  gem 'annotate'

  # Ruby用のrubocopとRails用のrubocop-railsを追加。(ターミナルでしか使わないため、require: falseを追加)
  gem 'rubocop', require: false
  gem 'rubocop-rails', require: false

  # letter_operner_webを利用するために追加
  gem 'letter_opener_web'

  # 　configを利用するために追加
  gem 'config'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  # Easy installation and use of chromedriver to run system tests with Chrome
  gem 'chromedriver-helper'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
# フォントオーサムを使用するため追加
gem 'font-awesome-sass'
