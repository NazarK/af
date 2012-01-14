RailsAdmin.authorize_with do
  redirect_to "/users/sign_in" unless warden.user.admin?
end

RailsAdmin.config do |config|
  config.excluded_models = [Favorite, Work, FavoriteUser]
end


