class Users::RegistrationsController < Devise::RegistrationsController

  def new
    super
  end

  def create
    build_resource(sign_up_params)
    if resource.save
      sign_up(resource_name, resource)
      respond_with resource, location: after_sign_up_path_for(resource)
    else
      clean_up_passwords resource
      respond_with resource
    end
  end

  def edit
  end

  def update
    super
  end

  def destroy
    # Overriding method so user can't destroy himself
    redirect_to root_path
  end

  def credentials_already_taken?
    render json: !User.user_exists?(params[:user][:email] || params[:user][:username])
  end

  private

  def after_sign_up_path_for(resource)
    root_path
  end

  def sign_up_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end

end
