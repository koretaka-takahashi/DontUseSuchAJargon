class GenresController < ApplicationController
  before_action :set_genre, only: [:show, :edit, :update]
  before_action :admin_check, only: [:edit, :update] # 管理者のみ画像のアップロード権限(アプリ側に設置)

  def index
    @genres = Genre.all.order(:id)
  end

  def show
    @genre = Genre.find(params[:id])
    @terms = @genre.terms.order(created_at: :desc).page(params[:page]).per(20)
  end  

  def edit
  end

  def update
    if @genre.update(genre_params)
      redirect_to root_path, notice: "更新しました。"
    else
      render :edit
    end
  end

  private

  def set_genre
    @genre = Genre.find(params[:id])
  end

  def genre_params
    params.require(:genre).permit(:name, :image)
  end
end
