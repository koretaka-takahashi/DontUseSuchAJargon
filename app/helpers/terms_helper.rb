module TermsHelper
  def new_or_edit
    if action_name == "new"
      terms_path
    elsif action_name == "edit"
      term_path
    end
  end

  def show_or_not # showアクションからの投稿ボタンがeditアクション扱いになる事を回避
    if action_name == "show" # ＠termがDBに存在すればnewしただけのインスタンスを再代入
      @term = Term.new
    else
      @term
    end
  end  
end
