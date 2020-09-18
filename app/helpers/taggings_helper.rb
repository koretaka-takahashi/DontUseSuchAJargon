module TaggingsHelper
  def tagging_new_or_edit
    if action_name == "new"
      term_taggings_path
    elsif action_name == "edit"
      term_tagging_path
    end
  end
end
