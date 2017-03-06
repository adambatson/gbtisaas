class MessagesController < ApplicationController
  before_action :verify_auth, :only => [:admin, :update, :destroy, :unapprove, :approve, :create, :index, :show]
  skip_before_action :verify_authenticity_token
  before_action :set_message, only: [:show, :edit, :update, :destroy, :unapprove, :approve, :upvote, :downvote]
  layout 'admin', :only => [:admin]

  def admin
    @active = "signatures"
    @title = "Signatures"
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

    _params = message_params
    if params.has_key? :key and !_params.has_key? :guestbook_id
      key = AccessKey.where(key: params[:key]).first
      if key != nil
        _params[:guestbook_id] = key.guestbook_id
      end
    end

    # Auto approve, if passes filter
    guestbook = Guestbook.find(_params[:guestbook_id])
    _params[:approved] = guestbook.auto_approve
    if guestbook.filter_profanity && Obscenity.profane?(_params[:content])
      _params[:approved] = false
    end

    @message = Message.new(_params)

    respond_to do |format|
      if @message.save
        format.html { redirect_back(fallback_location: '/admin/signatures') }
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
      format.html { redirect_back(fallback_location: '/admin/signatures') }
      format.json { head :no_content }
    end
  end

  def unapprove
    @message.approved = false
    @message.save
    respond_to do |format|
      format.html { redirect_back(fallback_location: '/admin/signatures') }
    end
  end

  def approve
    @message.approved = true
    @message.save
    respond_to do |format|
      format.html { redirect_back(fallback_location: '/admin/signatures') }
    end
  end

  def upvote
    if (cookies["last_vote_" + params[:id].to_s].blank?)
      @message.cast_vote true
      @message.inc_vote_count
      cookies["last_vote_" + params[:id].to_s] = {:value => "up"}
    elsif cookies["last_vote_" + params[:id].to_s] == "up"
      #undo vote
      @message.cast_vote false
      @message.dec_vote_count
      cookies["last_vote_" + params[:id].to_s] = {:value => ""}
    else 
      #Simple upvote
      @message.cast_vote true
      cookies["last_vote_" + params[:id].to_s] = {:value => "up"}
    end
    render json: {:votes => @message.votes, :state => cookies["last_vote_" + params[:id].to_s]}
  end

  def downvote
    if (cookies["last_vote_" + params[:id].to_s].blank?)
      @message.cast_vote false
      @message.inc_vote_count
      cookies["last_vote_" + params[:id].to_s] = {:value => "down"}
    elsif cookies["last_vote_" + params[:id].to_s] == "down"
      #undo vote
      @message.cast_vote true
      @message.dec_vote_count
      cookies["last_vote_" + params[:id].to_s] = {:value => ""}
    else 
      #Simple downvote
      @message.cast_vote true
      cookies["last_vote_" + params[:id].to_s] = {:value => "down"}
    end
    render json: {:votes => @message.votes, :state => cookies["last_vote_" + params[:id].to_s]}
  end

  def verify_auth    
    if request.format.json?
      require_key
    else
      require_login
    end
  end

  def require_key
    if !params.has_key? 'key' || !AccessKey.validate(params[:key])
      head(403)
    end
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
