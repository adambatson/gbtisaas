class AccessKeysController < ApplicationController
  before_action :require_login, :only => [:admin, :create, :destroy, :assign]
  layout 'admin', :only => [:admin]
  
  def admin
    @active = "access"
    @access_key = AccessKey.new
    @error = (params.has_key? :error) ? params[:error] : nil
    @guestbooks = Guestbook.where(archived: false).where(is_default: false)
    @default_guestbook = Guestbook.get_default
    @access_keys = AccessKey.all
  end

  def create
    _params = access_key_params
    if !params.has_key? 'guestbook_id'
      _params[:guestbook_id] = Guestbook.get_default.id
    end

    @access_key = AccessKey.new(_params)

    respond_to do |format|
      if @access_key.save
        format.html { redirect_to(:back) }
      else
        format.html { redirect_to(:back, error: @access_key.errors.full_messages.first) }
      end
    end
  end

  def destroy
    access_key = AccessKey.find(params[:id])
    access_key.destroy
    respond_to do |format|
      format.html { redirect_to(:back) }
      format.json { head :no_content }
    end
  end

  def assign
    guestbook = Guestbook.where(id: params[:guestbook_id]).first
    access_key = AccessKey.find(params[:id])
    if guestbook == nil
      guestbook = Guestbook.get_default
    end

    access_key.guestbook_id = guestbook == nil ? 0 : guestbook.id
    access_key.save

    respond_to do |format|
      format.html { redirect_to(:back) }
    end
  end

  private
    def access_key_params
      params.require(:access_key).permit(:label, :key, :guestbook_id)
    end
end
