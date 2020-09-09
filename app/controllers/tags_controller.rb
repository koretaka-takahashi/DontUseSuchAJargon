class TagsController < ApplicationController
before_action :set_tag, only: [:show, :edit, :update]
before_action :set_genre, only: [:index, :show, :new, :create] # 親ジャンルをセット
before_action :authenticate_user!, except: [:index, :show] # ログイン済みかどうか。
# タグに関しては運用自体考え中。

  def index
    @tags = Tag.all.order(:name)

  end

  def new
    @tag = Tag.new
    # binding.pry
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

  private

  def set_tag
    @tag = Tag.find(params[:id])
  end

  def set_genre
    @genre = Genre.find(params[:genre_id])
  end

  def tag_params
    params.require(:tag).permit(:name, :genre_id, :user_id)
  end
end
