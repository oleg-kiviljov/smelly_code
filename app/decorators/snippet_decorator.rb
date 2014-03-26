class SnippetDecorator < Draper::Decorator
  delegate_all

  def highlight_code(user_preferences)
    options = {
        linenos: user_preferences[:line_numbers],
        cssclass: "highlight #{user_preferences[:theme]}"
    }
    Pygments.highlight(object.smelly_body, lexer: object.lexer.name.downcase, options: options)
  end

  def format_code(user_preferences)
    h.simple_format(highlight_code(user_preferences)).html_safe
  end

  def status_label
    classes = %w{ label }
    if resolved?
      label = 'resolved'
      classes.push('label-success')
    else
      label = 'unresolved'
      classes.push('label-danger')
    end
    h.content_tag(:span, class: classes.join(' ')) do
      label
    end
  end

  def panel_heading_icon
    classes = %w{ fa pull-right }
    if resolved?
      classes.push('fa-plus')
    else
      classes.push('fa-minus')
    end
    h.content_tag(:i, nil, class: classes.join(' '))
  end

  def button
    classes = %w{btn btn-lg btn-block}
    if resolved?
      title = 'view snippet'
      classes.push('btn-primary')
    else
      title = 'submit solution'
      classes.push('btn-success')
    end
    h.link_to title, h.snippet_path(snippet), class: classes.join(' ')
  end

  def resolved?
    object.clean_body.present?
  end

end
