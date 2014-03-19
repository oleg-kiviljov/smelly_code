class SnippetDecorator < Draper::Decorator
  delegate_all

  def highlight_code(code, language)
    CodeRay.scan(code, language).div(css: :class)
    #Pygments.highlight(code, lexer: language)
  end

  def status_label
    classes = %w{ label }
    if resolved?
      label = 'Resolved'
      classes.push('label-success')
    else
      label = 'Unresolved'
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
