class UsersController < ApplicationController
  before_action :set_user, only: [:show, :destroy, :likes, :keeps] # ユーザーを特定しセット
  before_action :admin_check, only: [:index, :edit, :update, :destroy] # 管理者に編集削除権限(アプリ側に設置)
  before_action :user_check, only: [:likes, :keeps] # 本人のみにキープ一覧表示権限

  # ユーザー一覧（管理者用）
  def index
    @users = User.all
  end
  
  # プロフィール
  def show
  end  

  def destroy
    @user.destroy
    redirect_to users_path, notice: "ユーザー 「#{@user.name}」を削除しました。"
  end  

  # いいね！一覧
  def likes
    @likes = @user.likes.all.includes(description: :user)
  end

  # キープ一覧
  def keeps
    @keeps = @user.keeps.all.includes(term: :genre)
  end

  private

  # ユーザーを特定しセット
  def set_user
    @user = User.find(params[:id])
  end

  # 本人のみに権限を与える
  def user_check
    if @user != current_user
      flash[:alert] = "権限がありません。"
      redirect_back(fallback_location: root_path)
    end  
  end
end
