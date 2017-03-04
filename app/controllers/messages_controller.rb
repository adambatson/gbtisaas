class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :edit, :update, :destroy, :upvote, :downvote]
  layout 'admin', :only => [:admin]

  def admin
    @active = "signatures"
    @message = Message.new
    @guestbook = (params.has_key? :book_id) ? Guestbook.find(params[:book_id]) : Guestbook.get_default
    @error = (params.has_key? :error) ? params[:error] : nil
    @guestbooks = Guestbook.where(archived: false)
  end

  # GET /messages
  # GET /messages.json
  def index
    @messages = Message.all
  end

  # GET /messages/1
  # GET /messages/1.json
  def show
  end

  # GET /messages/new
  def new
    @message = Message.new
  end

  # GET /messages/1/edit
  def edit
  end

  # POST /messages
  # POST /messages.json
  def create
    @message = Message.new(message_params)

    respond_to do |format|
      if @message.save
        format.html { redirect_to(:back) }
        format.json { render :show, status: :created, location: @message }
      else
        format.html { redirect_to(:back, error: @message.errors.full_messages.first) }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /messages/1
  # PATCH/PUT /messages/1.json
  def update
    respond_to do |format|
      if @message.update(message_params)
        format.html { redirect_to @message, notice: 'Message was successfully updated.' }
        format.json { render :show, status: :ok, location: @message }
      else
        format.html { render :edit }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1
  # DELETE /messages/1.json
  def destroy
    @message.destroy
    respond_to do |format|
      params[:id] = @message.guestbook_id
      format.html { redirect_to(:back) }
      format.json { head :no_content }
    end
  end

  def upvote
    if (cookies[:last_vote] != "up" or cookies[:last_vote].blank?)
      @message.cast_vote true
      cookies[:last_vote] = {:value => "up"}
    end
    render json: {:votes => @message.votes}
  end

  def downvote
    if (cookies[:last_vote] != "down" or cookies[:last_vote].blank?)
      @message.cast_vote false
      cookies[:last_vote] = "down"
    end
    render json: {:votes => @message.votes}
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def message_params
      params.require(:message).permit(:content, :approved, :guestbook_id, :votes)
    end
end
