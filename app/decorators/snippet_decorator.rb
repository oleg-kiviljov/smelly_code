class SnippetDecorator < Draper::Decorator
  delegate_all

  def highlight_code(code, language)
    CodeRay.scan(code, language).div(css: :class)
    #Pygments.highlight(code, lexer: language)
  end

  def button
    classes = %w{btn btn-lg btn-block}
    if solved?
      title = 'view'
      classes.push('btn-primary')
    else
      title = 'refactor'
      classes.push('btn-success')
    end
    h.link_to title, h.snippet_path(snippet), class: classes.join(' ')
  end

  def solved?
    object.clean_body.present?
  end

end
