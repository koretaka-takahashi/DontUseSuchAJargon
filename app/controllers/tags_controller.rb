class TagsController < ApplicationController
before_action :authenticate_user!, except: [:index, :show] # ログイン済みかどうか。
before_action :set_tag, only: [:show, :edit, :update, :destroy]
before_action :set_genre, only: [:index, :show, :new, :create, :edit, :update, :destroy] # 親ジャンルをセット
before_action :user_check, only: [:edit, :update, :destroy] # 作成者に編集削除権限
before_action :admin_check, only: [:edit, :update, :destroy] # 管理者に編集削除権限

# タグに関しては運用自体考え中。

  def index
    @tags = Tag.where(genre_id: @genre.id).order(:name)
  end

  def new
    @tag = Tag.new
  end

  def create
    @tag = current_user.tags.build(tag_params)
    @tag.genre_id = @genre.id
    if @tag.save
      redirect_to genre_tags_path(@genre), notice: "タグを登録しました。"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @tag.update(tag_params)
      redirect_to genre_tags_path(@genre), notice: "更新しました。"
    else
      render :new
    end
  end

  def destroy
    @tag.destroy
    redirect_to genre_tags_path(@genre), notice: "タグ「#{@tag.name}」を削除しました。"
  end

  private

  def set_tag
    @tag = Tag.find(params[:id])
  end

  def set_genre
    @genre = Genre.find(params[:genre_id])
  end

  def tag_params
    params.require(:tag).permit(:name, :user_id, :genre_id)
  end

  # 投稿者本人もしくは管理者かどうか
  def user_check
    if @tag.user != current_user && current_user.try(:admin?) == false
      flash[:alert] = "権限がありません。"
      redirect_back(fallback_location: root_path)
    end  
  end
end
