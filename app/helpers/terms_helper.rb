module TermsHelper
  def new_or_edit
    if action_name == "new"
      terms_path
    elsif action_name == "edit"
      term_path
    end
  end
end
