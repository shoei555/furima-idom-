class ApplicationController < ActionController::Base
  before_action :basic_auth # Basic認証機能を有効化
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  # deviseのUserモデルにパラメーターを許可
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,
                                      keys: [:nick_name, :kanji_first_name, :kanji_last_name, :kana_first_name, :kana_last_name,
                                             :birthday_yyyy_mm_dd])
  end

  def basic_auth # Basic認証機能の実装
    authenticate_or_request_with_http_basic do |username, password|
      username == 'mita-jiro' && password == '263150' # 環境変数でname/passを設定
    end
  end
end
