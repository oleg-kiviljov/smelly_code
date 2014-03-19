class SnippetDecorator < Draper::Decorator
  delegate_all

  def highlight_code(code, language)
    CodeRay.scan(code, language).div(css: :class)
    #Pygments.highlight(code, lexer: language)
  end

  def status_label
    classes = %w{ label }
    if solved?
      label = 'Solved'
      classes.push('label-success')
    else
      label = 'Unsolved'
      classes.push('label-danger')
    end
    h.content_tag(:span, class: classes.join(' ')) do
      label
    end
  end

  def panel_heading_icon
    classes = %w{ fa pull-right }
    if solved?
      classes.push('fa-plus')
    else
      classes.push('fa-minus')
    end
    h.content_tag(:i, nil, class: classes.join(' '))
  end

  def button
    classes = %w{btn btn-lg btn-block}
    if solved?
      title = 'view post'
      classes.push('btn-primary')
    else
      title = 'submit solution'
      classes.push('btn-success')
    end
    h.link_to title, h.snippet_path(snippet), class: classes.join(' ')
  end

  def solved?
    object.clean_body.present?
  end

end
