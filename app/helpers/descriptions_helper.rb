module DescriptionsHelper
  def description_new_or_edit
    if action_name == "new"
      term_descriptions_path
    elsif action_name == "edit"
      term_description_path
    end
  end
end
