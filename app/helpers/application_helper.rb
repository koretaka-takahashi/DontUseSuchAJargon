module ApplicationHelper
  def search_or_index
    if params[:q]
      set_search
    end
  end
end
