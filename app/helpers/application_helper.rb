module ApplicationHelper
  def blueprint_container
    params[:show_grid] == 'true' ? 'container showgrid' : 'container'
  end
  def menu_tab_link(label, url)
    content_tag(:li, link_to( label, url, {:class=>(current_page?(url) ? 'selected' : "")}))
  end
  def page_title(default_title)
    content_for(:title).blank? ? default_title : content_for(:title)
  end
end
