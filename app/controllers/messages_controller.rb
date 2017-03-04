class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :edit, :update, :destroy, :upvote, :downvote]
  skip_before_filter :verify_authenticity_token

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
    _params = message_params
    if _params[:guestbook_id] == nil
      _params[:guestbook_id] = Guestbook.get_default.id
    end
    @message = Message.new(_params)

    respond_to do |format|
      if @message.save
        format.html { redirect_to @message, notice: 'Message was successfully created.' }
        format.json { render :show, status: :created, location: @message }
      else
        format.html { render :new }
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
      format.html { redirect_to messages_url, notice: 'Message was successfully destroyed.' }
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
