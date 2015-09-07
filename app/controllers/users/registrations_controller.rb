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
    @options_for_snippet_example = options_for_snippet_example
  end

  def update
    value = params[:value].downcase
    if params[:value] == "false"
      value = false
    elsif params[:value] == "true"
      value = true
    end
    current_user.settings(:snippets).update_attributes! params[:preference] => value
    head :ok
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

  def options_for_snippet_example
    smelly_code_example = "def create
    @snippet = current_user.snippets.build(snippet_params)
    if @snippet.save
      flash[:success] = 'Snippet created successfully.'
      redirect_to snippets_path
    else
      flash[:error] = \"Couldn't create snippet.\"
      redirect_to new_snippet_path
    end
  end"
    {
      snippet: Snippet.new,
      lexer: 'Ruby',
      smelly_code: smelly_code_example,
      title: 'Example code'
    }
  end

end
