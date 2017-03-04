class GuestbooksController < ApplicationController
  before_action :set_guestbook, only: [:show, :edit, :update, :destroy]

  # GET /guestbooks
  # GET /guestbooks.json
  def index
    @guestbooks = Guestbook.all
  end

  # GET /guestbooks/1
  # GET /guestbooks/1.json
  def show
    #abort @guestbook.messages.inspect
    #@messages = Message.where('guestbook_id = ' + params[:id])
    respond_to do |format|
      format.html {
        case sort_params[:sort_by]
        when 'recent'
          @messages = Message.where('guestbook_id = ' + params[:id]).order('created_at DESC')
        when 'votes'
          @messages = Message.where('guestbook_id = ' + params[:id]).order('votes DESC')
        when 'alphabet'
          @messages = Message.where('guestbook_id = ' + params[:id]).order('content ASC')
        when 'controversial'
          @messages = Message.where('guestbook_id = ' + params[:id]).order('(votes_cast - votes) DESC')
        else
          @messages = Message.where('guestbook_id = ' + params[:id])
        end
      }
      format.json {render json: @guestbook}
    end
    
  end

  # GET /guestbooks/new
  def new
    @guestbook = Guestbook.new
  end

  # GET /guestbooks/1/edit
  def edit
  end

  # POST /guestbooks
  # POST /guestbooks.json
  def create
    @guestbook = Guestbook.new(guestbook_params)

    respond_to do |format|
      if @guestbook.save
        format.html { redirect_to @guestbook, notice: 'Guestbook was successfully created.' }
        format.json { render :show, status: :created, location: @guestbook }
      else
        format.html { render :new }
        format.json { render json: @guestbook.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /guestbooks/1
  # PATCH/PUT /guestbooks/1.json
  def update
    respond_to do |format|
      if @guestbook.update(guestbook_params)
        format.html { redirect_to @guestbook, notice: 'Guestbook was successfully updated.' }
        format.json { render :show, status: :ok, location: @guestbook }
      else
        format.html { render :edit }
        format.json { render json: @guestbook.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /guestbooks/1
  # DELETE /guestbooks/1.json
  def destroy
    @guestbook.destroy
    respond_to do |format|
      format.html { redirect_to guestbooks_url, notice: 'Guestbook was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def set_default
    Guestbook.where("is_default=true").each do |book|
      book.toggle_default
    end
    default = Guestbook.find(params[:id])
    default.toggle_default
    render json: {:guestbook => default}
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_guestbook
      @guestbook = Guestbook.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def guestbook_params
      params.require(:guestbook).permit(:title, :archived)
    end

    def sort_params
      params.permit(:sort_by)
    end
end
