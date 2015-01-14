module AuthHelper
  def http_login
    username = ENV.fetch('USERNAME')
    password = ENV.fetch('PASSWORD')
    request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(username, password)
  end
end
