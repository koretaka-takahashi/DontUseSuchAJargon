class CommentsController < ApplicationController
  before_action :set_comment, only: [:new, :edit, :update, :destroy]
  before_action :set_description, only: [:index, :new, :create, :edit, :update, :destroy]
  before_action :set_term, only: [:new, :create, :edit, :update, :destroy]

  def index
  end

  def new # 返信の時しか通らない
    @reply = @description.comments.build
    @reply.user_id = current_user.id
    # ここまででは@replyも取れてる
    respond_to do |format|
      flash.now[:notice] = 'コメントの返信中...'
      format.js { render :reply }
    end
  end
  
  def create
    @comment = @description.comments.build(comment_params)
    @comment.user_id = current_user.id
    respond_to do |format|
      if @comment.save
        if @comment.parent_id.present? # 返信の場合
          flash.now[:notice] = 'コメントに返信しました。' 
          format.js { render :add_reply }
        else # ただのコメントの場合
          flash.now[:notice] = 'コメントしました。' 
          format.js { render :index }
        end
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
      # 実際に内容が変わっている場合
      if @comment.content != comment_params[:content] && @comment.update(comment_params)
        flash.now[:notice] = 'コメントが編集されました。' 
        if @comment.parent.present?
          format.js { render :index_for_update_reply }
        else
          format.js { render :index_for_update }
        end  
      elsif @comment.update(comment_params) # 内容が変わっていない場合
        format.js { render :index_for_update }
      else # updateできなかった場合
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
    params.require(:comment).permit(:user_id, :description_id, :content, :parent_id)
  end
end
