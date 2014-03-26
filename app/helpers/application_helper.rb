module ApplicationHelper

  def highlight_code(code, lexer)
    options = {
        linenos: user_preferences[:line_numbers],
        cssclass: "highlight #{user_preferences[:theme]}"
    }
    Pygments.highlight(code, lexer: lexer.downcase, options: options)
  end

end
