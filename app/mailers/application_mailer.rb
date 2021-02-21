class ApplicationMailer < ActionMailer::Base
  #メールの送信元のデフォルト設定を変更
  default from: 'instaclone@example.com'
  #　メイラーにもレイアウトファイルがある。
  layout 'mailer'
end
