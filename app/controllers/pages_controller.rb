class PagesController < ApplicationController

  def faq
    @faqs = Faq.all
  end

end
