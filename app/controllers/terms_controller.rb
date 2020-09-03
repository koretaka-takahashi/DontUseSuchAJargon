class TermsController < ApplicationController
  before_action :set_term, only: [:show, :edit, :update, :destroy]
  before_action :set_genres, only: [:new, :edit] # 選択ボックスの為ジャンルを全てセット。
  before_action :authenticate_user!, except: [:index, :show] # ログイン済みかどうか。
  # before_action :user_check, only: [:edit, :update, :destroy]
  # ↑ 作成者かどうか。現在は不要と判断。いずれ管理者機能実装時に管理者にのみ権限付与予定。

  def index
    @terms = Term.all.order(created_at: :desc)
  end

  def show
    @descriptions = @term.descriptions.all.order(created_at: :desc)
  end

  def new
    @term = Term.new
  end

  def create
    @term = current_user.terms.build(term_params)
    if @term.save
      redirect_to terms_path, notice: "新しく用語を登録しました"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @term.update(term_params)
      redirect_to terms_path, notice: "更新しました"
    else
      render :new
    end
  end

  def destroy
    @term.destroy
    redirect_to terms_path, notice: "タイトル「#{@term.name}」を削除しました"
  end

  private

  def set_term
    @term = Term.find(params[:id])
  end

  def set_genres
    @genres = Genre.all
  end

  def term_params
    params.require(:term).permit(:name, :user_id, :genre_id)
  end

  def user_check
    if @term.user != current_user
      flash[:alert] = "権限がありません。"
      redirect_back(fallback_location: root_path)
    end  
  end
end
