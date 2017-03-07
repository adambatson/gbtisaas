class GuestbooksController < ApplicationController
  before_action :require_login, :only => [:admin, :create, :update, :destroy, :set_default, :toggle_visibility, :archive, :export]
  before_action :set_guestbook, only: [:show, :edit, :update, :destroy]
  skip_before_action :verify_authenticity_token
  layout 'admin', :only => [:admin]

  def admin
    @active = "guestbooks"
    @title = "Guestbooks"
    @guestbook = Guestbook.new
    @error = (params.has_key? :error) ? params[:error] : nil
    @open_books = Guestbook.where(archived: false)
    @archived_books = Guestbook.where(archived: true)
  end

  # GET /guestbooks
  # GET /guestbooks.json
  def index
    respond_to do |format|
      format.html { redirect_to root_path }
      format.json {
        if params.has_key? :key
          key = AccessKey.where(key: params[:key]).first
          if key != nil
            render json: key.guestbook.approved_messages
            return
          end
        end
        render json: Guestbook.get_default.approved_messages
      }
    end
  end

  # GET /guestbooks/1
  # GET /guestbooks/1.json
  def show
    #abort @guestbook.messages.inspect
    #@messages = Message.where('guestbook_id = ' + params[:id])
    respond_to do |format|
      format.html { redirect_to "/view/#{@guestbook.id}" }
      format.json {
        if params.has_key? :key
          key = AccessKey.where(key: params[:key]).first
          if key != nil
            render json: key.guestbook.approved_messages.content
            return
          end
        end
        render json: Guestbook.get_default.approved_messages.content}
    end
  end

  # POST /guestbooks
  # POST /guestbooks.json
  def create
    @guestbook = Guestbook.new(guestbook_params)

    respond_to do |format|
      if @guestbook.save
        format.html { redirect_back(fallback_location: '/admin/guestbooks') }
        format.json { render :show, status: :created, location: @guestbook }
      else
        format.html { redirect_to action: :admin, error: @guestbook.errors.full_messages.first }
        format.json { render json: @guestbook.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /guestbooks/1
  # PATCH/PUT /guestbooks/1.json
  def update
    respond_to do |format|
      if @guestbook.update(guestbook_params)
        format.html { redirect_back(fallback_location: '/admin/guestbooks') }
        format.json { render :show, status: :ok, location: @guestbook }
      else
        format.html { redirect_back(fallback_location: '/admin/guestbooks') }
        format.json { render json: @guestbook.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /guestbooks/1
  # DELETE /guestbooks/1.json
  def destroy
    @guestbook.destroy
    respond_to do |format|
      format.html { redirect_back(fallback_location: '/admin/guestbooks') }
      format.json { head :no_content }
    end
  end

  def set_default
    Guestbook.where("is_default=true").each do |book|
      book.toggle_default
    end
    default = Guestbook.find(params[:id])
    default.toggle_default

    respond_to do |format|
      format.html { redirect_back(fallback_location: '/admin/guestbooks') }
      format.json { render json: {:guestbook => default} }
    end
  end

  def toggle_visibility
    book = Guestbook.find(params[:id])
    book.visible = !book.visible
    book.save

    respond_to do |format|
      format.html { redirect_back(fallback_location: '/admin/guestbooks') }
      format.json { render json: {:guestbook => book} }
    end
  end

  def archive
    book = Guestbook.find(params[:id])
    book.archive
    redirect_to :admin
  end

  def export
    require 'csv'
    book = Guestbook.find(params[:id])
    csv = CSV.generate do |csv|
      csv << ["Message", "Saved"]
      book.approved_messages.each do |message|
        csv << [message.content, message.created_at]
      end
    end

    send_data csv, :type => 'text/csv', :filename => book.title + '.csv'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_guestbook
      @guestbook = Guestbook.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def guestbook_params
      params.require(:guestbook).permit(:title, :description, :archived, :auto_approve, :filter_profanity)
    end

    def sort_params
      params.permit(:sort_by)
    end
end
