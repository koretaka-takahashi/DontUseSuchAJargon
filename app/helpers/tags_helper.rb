module TagsHelper
  def tag_new_or_edit
    if action_name == "new"
      genre_tags_path
    elsif action_name == "edit"
      genre_tag_path
    end
  end
end
