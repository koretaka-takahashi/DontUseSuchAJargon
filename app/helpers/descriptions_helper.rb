module DescriptionsHelper
  def description_new_or_edit
    # binding.pry
    if action_name == "new" || action_name == "create"
      term_descriptions_path
    elsif action_name == "edit" || action_name == "update"
      term_description_path
    end
  end
end
