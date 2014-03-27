class SnippetDecorator < Draper::Decorator
  delegate_all

  def format_code(code)
    h.highlight_code(code, object.lexer.name).html_safe
  end

  def status_label
    classes = %w{ label hidden-xs }
    if resolved?
      label = 'clean :)'
      classes.push('label-success')
    else
      label = 'smelly :('
      classes.push('label-danger')
    end
    h.content_tag(:span, class: classes.join(' ')) do
      label
    end
  end

  def panel_heading_icon(user_preferences)
    classes = %w{ fa pull-right }
    if user_preferences[:minimize]
      classes.push('fa-plus')
    else
      classes.push('fa-minus')
    end
    h.content_tag(:i, nil, class: classes.join(' '))
  end

  def resolved?
    object.clean_body.present?
  end

end
