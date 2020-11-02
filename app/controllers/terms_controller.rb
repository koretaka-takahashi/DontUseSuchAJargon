class TermsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show] # ログイン済みかどうか。
  before_action :set_term, only: [:show, :edit, :update, :destroy]
  before_action :set_genres, only: [:new, :edit] # 選択ボックスの為ジャンルを全てセット。
  # before_action :set_tags, only: [:show] # タグ付け時に選ぶリスト用に取得しておく（いらない？）
  before_action :set_tagging, only: [:show]
  before_action :user_check, only: [:edit, :update] # 投稿者に編集権限
  before_action :admin_check, only: [:edit, :update, :destroy] # 管理者に編集削除権限



  def index
  end

  def show
    @descriptions = @term.descriptions.all.order(created_at: :desc)
  end

  # def new
  #   @term = Term.new
  # end

  def create
    @term = current_user.terms.build(term_params)
    if @term.save
      redirect_to term_path(@term), notice: '新しくTermを登録しました。'
    else
      render :failure # エラーメッセージを出す
    end
  end

  def edit
  end

  def update
    if @term.update(term_params)
      redirect_to term_path(@term), notice: "更新しました。"
    else
      render :new
    end
  end

  def destroy
    @term.destroy
    redirect_to terms_path, notice: "タイトル「#{@term.name}」を削除しました。"
  end

  private

  def set_term
    @term = Term.find(params[:id])
  end

  def set_genres
    @genres = Genre.all
  end

  def set_tagging
    @tagging = @term.taggings.build
  end

  # いらないっぽい！？  
  # def set_tags
  #   @tags = Tags.where(genre_id: @term.genre_id).all.order(:name)
  # end  

  def term_params
    params.require(:term).permit(:name, :user_id, :genre_id, tag_ids: [])
  end

  # 投稿者本人かどうか
  def user_check
    if @term.user != current_user
      flash[:alert] = "権限がありません。"
      redirect_back(fallback_location: root_path)
    end  
  end
end
