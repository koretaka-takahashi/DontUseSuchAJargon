class TermsController < ApplicationController
  before_action :set_term, only: [:show, :edit, :update, :destroy]

  def index
    @terms = Term.all
  end

  def show
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

  def term_params
    params.require(:term).permit(:name, :user_id, :genre_id)
  end
end
