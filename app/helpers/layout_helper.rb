# These helper methods can be called in your template to set variables to be used in the layout
# This module should be included in all views globally,
# to do so you may need to add this line to your ApplicationController
#   helper :layout
module LayoutHelper
  def title(page_title, show_title = true)
    @content_for_title = page_title.to_s
    @show_title = show_title
  end
  
  def show_title?
    @show_title
  end

  def hide_back_link(hide_link = false)
    @hide_back_link = hide_link
  end

  def hide_back_link?
    @hide_back_link
  end

  def back_link(url)
    content_for :toolbar_button_left, link_to('Back', url, :class => "back_button toolbar_button_left button", :rel => '_ajax')
  end
  
  def stylesheet(*args)
    content_for(:head) { stylesheet_link_tag(*args) }
  end
  
  def javascript(*args)
    content_for(:head) { javascript_include_tag(*args) }
  end
end
