class Users::SessionsController < Devise::SessionsController

  def new
    super
  end

  def create
    self.resource = warden.authenticate!(scope: resource_name, recall: "#{controller_path}#cannot_sign_in")
    sign_in(resource_name, resource)
    flash[:success] = t('devise.sessions.signed_in')
    redirect_to after_sign_in_path_for(resource)
  end

  def destroy
    Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)
    flash[:success] = t('devise.sessions.signed_out')
    redirect_to after_sign_out_path_for(resource)
  end

  def cannot_sign_in
    flash[:danger] = t('devise.failure.invalid')
    redirect_to root_path
  end

  private

  def after_sign_in_path_for(resource)
    root_path
  end

  def after_sign_out_path_for(resource)
    root_path
  end

end
