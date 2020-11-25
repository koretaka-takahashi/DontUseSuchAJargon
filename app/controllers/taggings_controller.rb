class TaggingsController < ApplicationController
  before_action :authenticate_user! # ログイン済みかどうか。
  before_action :set_term, only: [:create, :destroy]
  before_action :admin_check, only: [:create, :destroy] # 管理者に削除権限

  def create
    @tagging = @term.taggings.build(tagging_params)
    if @tagging.save
      redirect_to term_path(@term), notice: "#{@tagging.tag.name} をタグ付けしました。"
    else
      redirect_to term_path(@term)
    end
  end

  def destroy
    tagging = @term.taggings.find_by(tag_id: params[:id])
    tagging.destroy
    redirect_to term_path(@term), notice: "タグ #{tagging.tag.name}を外しました。"
  end

  private

  def set_term
    @term = Term.find(params[:term_id])
  end

  def tagging_params 
    params.require(:tagging).permit(:tag_id, :term_id)
  end
end
