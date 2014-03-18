class SnippetDecorator < Draper::Decorator
  delegate_all

  def highlight_code(code, language)
    CodeRay.scan(code, language).div
  end

  def button
    if solved?
      h.link_to 'View snippet', h.snippet_path(snippet), class: 'btn btn-primary btn-lg btn-block'
    else
      h.link_to 'Submit solution', '#', class: 'btn btn-success btn-lg btn-block'
    end
  end

  def solved?
    object.clean_body.present?
  end

end
