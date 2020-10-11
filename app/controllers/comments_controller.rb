class CommentsController < ApplicationController
  before_action :set_comment, only: [:edit, :update, :destroy]
  before_action :set_description, only: [:index, :create, :edit, :update, :destroy]
  before_action :set_term, only: [:create, :edit, :update, :destroy]

  def index
  end
  
  def create
    @comment = @description.comments.build(comment_params)
    @comment.user_id = current_user.id
    respond_to do |format|
      if @comment.save
        format.js { render :index }
      else
        format.js { render :create_error }
      end
    end
  end

  def edit
    respond_to do |format|
      flash.now[:notice] = 'コメントの編集中...'
      format.js { render :edit }
    end
  end

  def update
    respond_to do |format|
      if @comment.content != comment_params[:content] && @comment.update(comment_params)
        flash.now[:notice] = 'コメントが編集されました。' 
        format.js { render :index }
      elsif @comment.update(comment_params)
        format.js { render :index }
      else
        format.js { render :edit_error }
      end
    end
  end

  def destroy
    @comment.destroy
    respond_to do |format|
      flash.now[:notice] = 'コメントが削除されました。'
      format.js { render :index }
    end
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def set_description
    @description = Description.find(params[:description_id])
  end

  def set_term
    @term = Term.find(params[:term_id])
  end

  def comment_params
    params.require(:comment).permit(:user_id, :description_id, :content)
  end
end
