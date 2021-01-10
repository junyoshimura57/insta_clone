# 今後マイページに機能追加を想定して基底クラスを作成する。()
class Mypage::BaseController < ApplicationController
  before_action :require_login
  # マイページ専用のlayoutファイルを読み込ませる。
  layout 'mypage'
end
