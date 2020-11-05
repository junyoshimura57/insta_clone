# 今回は全体設定として1ページに10件表示とする。(perメソッド、各モデルにpaginates_perを記載でも設定可能)
Kaminari.configure do |config|
  config.default_per_page = 15
end
