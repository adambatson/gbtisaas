module ApplicationHelper
  def admin_nav(path, label, is_active)
    is_active ?
      "<li class=\"active\"><a href=\"#{path}\">#{label} <span class=\"sr-only\">(current)</span></a></li>".html_safe :
      "<li><a href=\"#{path}\">#{label}</a></li>".html_safe
  end
end