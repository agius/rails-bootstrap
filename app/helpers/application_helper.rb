module ApplicationHelper
  
  def devise_error_messages!
    return "" if resource.errors.empty?

    messages = resource.errors.full_messages.map { |msg| content_tag(:li, msg) }.join
    sentence = I18n.t("errors.messages.not_saved",
                      :count => resource.errors.count,
                      :resource => resource.class.model_name.human.downcase)

    html = <<-HTML
    <div id="error_explanation" class="alert clearfix">
      <h4>#{sentence}</h4>
      <ul>#{messages}</ul>
    </div>
    HTML

    html.html_safe
  end
  
  def bootstrap_paginate(pages, options={})
    options.reverse_merge!(
      :class => 'pagination', 
      :renderer => BootstrapLinkRenderer, 
      :previous_label => '&lt;&lt;'.html_safe, 
      :next_label => '&gt;&gt;'.html_safe
    )
    will_paginate(pages, options)
  end
  
  # improved version of https://gist.github.com/1160287
  def wrap(str, opts = {})
    opts = opts.with_indifferent_access
    max_len = opts[:max_length] || 20
    seperator = opts[:seperator] || "<wbr>"
    return str unless str.length > max_len
    ret = ""
    begin
      idx = str.index(seperator)
      if idx.nil? || idx > max_len
        ret += str[0..max_len]
        str = str[(max_len + 1)..-1]
      else
        ret += str[0..idx]
        str = str[(idx + 1)..-1]
      end
      ret << seperator
    end while str.present?
    
    ret.html_safe
  end
end