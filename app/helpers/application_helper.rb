module ApplicationHelper

  def highlight_code(code, lexer)

    if user_preferences[:line_numbers] == true
      line_numbers = 'inline'
    else
      line_numbers = false
    end

    options = {
        linenos: line_numbers,
        cssclass: "highlight #{user_preferences[:theme]}",
        lineseparator: '<br>'
    }
    simple_format(Pygments.highlight(code, lexer: lexer.downcase, options: options)).html_safe
  end

end
