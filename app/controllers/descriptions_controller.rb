class DescriptionsController < ApplicationController
  before_action :authenticate_user!, except: [:show] # ログイン済みかどうか。
  before_action :set_description, only: [:show, :edit, :update, :destroy]
  before_action :set_term, only: [:show, :new, :create] # 親になるTermを設定
  before_action :user_check, only: [:edit, :update, :destroy] # 投稿者に編集削除権限
  before_action :admin_check, only: [:edit, :update, :destroy] # 管理者に編集削除権限


  def show
    # コメント一覧で親コメントのみ表示する
    @comments = @description.comments.where(parent_id: nil).order(created_at: :asc)
    # コメント新規作成の為
    @comment = @description.comments.build
    # 返信の新規作成の為
    @reply = @description.comments.build
  end

  def new
    @description = Description.new
  end

  def create
    @description = current_user.descriptions.build(description_params)
    @description.term_id = @term.id
    if @description.save
      redirect_to term_description_path(@description.term, @description), notice: "解説を投稿しました。"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @description.update(description_params)
      redirect_to term_path(@description.term), notice: "更新しました。"
    else
      render :edit
    end
  end

  def destroy
    @description.destroy
    redirect_to term_path(@description.term), notice: "解説を削除しました。"
  end

  private

  def set_description
    @description = Description.find(params[:id])
  end

  def set_term
    @term = Term.find(params[:term_id])
  end

  def description_params
    params.require(:description).permit(:content, :user_id, :term_id)
  end

  # 投稿者本人もしくは管理者かどうか
  def user_check
    if @description.user != current_user && current_user.try(:admin?) == false
      flash[:alert] = "権限がありません。"
      redirect_back(fallback_location: root_path)
    end  
  end
end

