module ApplicationHelper
  def form_group_tag(errors, &block)
    css_class = "form-group"
    css_class << "has-error" if errors.any?
    content_tag :div, capture(&block), class: css_class
  end

  def markdown_to_html(markdown)
    renderer = Redcarpet::Render::HTML.new
    extensions = { fenced_code_blocks: true}
    redcarpet = Redcarpet::Markdown.new(renderer, extensions)
    (redcarpet.render markdown).html_safe
  end

end
