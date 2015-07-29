Garage.configure {}

Garage::TokenScope.configure do
  register :public, desc: 'accessing publicly available data' do
    access :read, User
    access :write, User
  end
end

Garage.configuration.strategy = Garage::Strategy::Doorkeeper

Doorkeeper.configure do
  orm :active_record
  default_scopes :public
  optional_scopes(*Garage::TokenScope.optional_scopes)

  resource_owner_authenticator do
    current_user || redirect_to(new_user_session_path)
  end

  resource_owner_from_credentials do |routes|
    request.params[:user] = { email: request.params[:username], password: request.params[:password] }
    request.env['devise.allow_params_authentication'] = true
    request.env['warden'].authenticate!(scope: :user)
  end
end

Doorkeeper.configuration.token_grant_types << "password"
