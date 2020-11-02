class KeepsController < ApplicationController
  before_action :authenticate_user! # ログイン済みかどうか。
  before_action :set_term

  def create
    @keep = current_user.keeps.build(term_id: @term.id)
    @keep.save
  end

  def destroy
    keep = current_user.keeps.find_by(term_id: @term.id)
    keep.destroy
  end

  private

  def set_term
    @term = Term.find(params[:term_id])
  end
end
