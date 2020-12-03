class KeepsController < ApplicationController
  before_action :authenticate_user! # ログイン済みかどうか。
  before_action :set_term
  before_action :set_keep, only: [:destroy, :destroy2] 
  # before_action :user_check # キープした本人にのみ削除権限　いやいやこの機能そもそもおかしいじゃん　キープした本人も何も本人がキープしてるかどうか見る場所なんだから。

  def create
    @keep = current_user.keeps.build(term_id: @term.id)
    @keep.save
  end

  def create2
    @keep = current_user.keeps.build(term_id: @term.id)
    @keep.save
  end

  def destroy
    @keep.destroy
  end

  def destroy2
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
# この機能そもそもおかしい　本人がキープしてるかどうか本人だけが見る場所なんだからキープした本人も何もない。
