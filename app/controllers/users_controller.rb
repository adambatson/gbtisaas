class UsersController < Clearance::UsersController
  before_action :require_login, :only => [:admin, :_create, :_destroy]
  layout 'admin', :only => [:admin]

  def admin
    @active = "accounts"
    @title = "Accounts"
    @user = User.new
    @users = User.all
    @error = (params.has_key? :error) ? params[:error] : nil
  end

  def _create
    _params = user_params
    @user = User.new(_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_back(fallback_location: '/admin/accounts') }
      else
        format.html { redirect_to action: :admin, error: @user.errors.full_messages.first }
      end
    end
  end

  def _destroy
    user = User.find(params[:id])
    user.destroy
    respond_to do |format|
      format.html { redirect_back(fallback_location: '/admin/accounts') }
    end
  end

  private
    def user_params
      params.require(:user).permit(:email, :password)
    end
end
