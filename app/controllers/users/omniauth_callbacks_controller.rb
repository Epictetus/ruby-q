class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def twitter
    auth_params = request.env['omniauth.auth']
    auth = Authentication.find_or_initialize_by_provider_and_uid(auth_params['provider'], auth_params['uid'])
    if auth.new_record?
      auth.build_user(:name => auth_params['user_info']['name'])
      unless auth.save
        # TODO handle errors
      end
    end
    # TODO flash[:notice] = I18n.t 'devise.omniauth_callbacks.success', :kind => 'Twitter'
    sign_in_and_redirect auth.user, :event => :authentication
  end
end
