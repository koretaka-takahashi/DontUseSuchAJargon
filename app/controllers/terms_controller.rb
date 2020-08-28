class TermsController < ApplicationController
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
  end

  def destroy
  end

  private

  def term_params
    params.require(:term).permit(:name, :user_id, :genre_id)
  end
end
