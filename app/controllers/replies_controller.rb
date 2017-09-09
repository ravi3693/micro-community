class RepliesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_reply, only: [:show, :edit, :update, :destroy]

  # GET /replies
  # GET /replies.json
  def index
    @comment = Comment.find(params[:comment_id])
    @replies = @comment.replies
  end

  # GET /replies/1
  # GET /replies/1.json
  def show
  end

  # GET /replies/new
  def new
    @comment = Comment.find(params[:comment_id])
    @reply = @comment.replies.build
  end

  # GET /replies/1/edit
  def edit
  end

  # POST /replies
  # POST /replies.json
  def create
    @comment = Comment.find(params[:comment_id])
    @reply = @comment.replies.build(reply_params)
    if @reply.save
      render json: {message: "success", reply: @reply }
    else
      render json: { message: "errors" }
    end
  end

  # PATCH/PUT /replies/1
  # PATCH/PUT /replies/1.json
  def update
    respond_to do |format|
      if @reply.update(reply_params)
        format.html { redirect_to @reply, notice: 'Reply was successfully updated.' }
        format.json { render :show, status: :ok, location: @reply }
      else
        format.html { render :edit }
        format.json { render json: @reply.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /replies/1
  # DELETE /replies/1.json
  def destroy
    @reply.destroy
    respond_to do |format|
      format.html { redirect_to replies_url, notice: 'Reply was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reply
      @reply = Reply.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def reply_params
      params.require(:reply).permit(:body)
    end
end
