class KeepsController < ApplicationController
  before_action :authenticate_user! # ログイン済みかどうか。
  before_action :set_term
  before_action :set_keep, only: [:destroy] 
  before_action :user_check, only: [:destroy] # キープした本人にのみ削除権限

  def create
    @keep = current_user.keeps.build(term_id: @term.id)
    @keep.save
  end

  def destroy
    @keep.destroy
  end

  private

  def set_keep
    @keep = current_user.keeps.find_by(term_id: @term.id)
  end

  def set_term
    @term = Term.find(params[:term_id])
  end

  # キープした本人かどうか
  def user_check
    if @keep.user != current_user
      flash[:alert] = "権限がありません。"
      redirect_back(fallback_location: root_path)
    end  
  end
end
