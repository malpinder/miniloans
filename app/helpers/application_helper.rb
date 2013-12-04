module ApplicationHelper
  def nav_link_for(name, path, options={})
    active = 'active' if current_page?(path)
    content_tag(:li, class: active) do
      link_to name, path, options
    end
  end
end
