class CommentsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show] # ログイン済みかどうか。
  before_action :set_comment, only: [:new, :edit, :update, :destroy]
  before_action :set_description, only: [:index, :new, :create, :edit, :update, :destroy]
  before_action :set_term, only: [:new, :create, :edit, :update, :destroy]
  before_action :user_check, only: [:edit, :update, :destroy] # 投稿者に編集削除権限
  before_action :admin_check, only: [:destroy] # 管理者に削除権限

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
      # ただのコメントの場合
      if @comment.parent_id.nil?
        if @comment.save
          flash.now[:notice] = 'コメントしました。' 
          format.js { render :index }
        else
          format.js { render :create_error }
        end
      # 返信の場合
      else
        if @comment.save
          flash.now[:notice] = 'コメントに返信しました。' 
          format.js { render :add_reply }
        else
          format.js { render :reply_error }
        end
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

  # 投稿者本人もしくは管理者かどうか
  def user_check
    if @comment.user != current_user && current_user.try(:admin?) == false
      flash[:alert] = "権限がありません。"
      redirect_back(fallback_location: root_path)
    end  
  end
end
