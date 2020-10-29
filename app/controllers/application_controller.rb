class ApplicationController < ActionController::Base
  # デフォルトのフラッシュメッセージは、noticeとalertのキーしか使えないため以下を追加。
  add_flash_types :success, :info, :warning, :danger
end
