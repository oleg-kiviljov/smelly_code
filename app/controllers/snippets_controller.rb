class SnippetsController < ApplicationController

  before_action :authenticate_user!, except: [:index, :show]

  def index
    snippet_collection = Snippet.all.includes(:lexer)
    if params[:filters]
      snippet_collection = apply_filters(params[:filters], snippet_collection)
    elsif params[:lexer]
      snippet_collection = Lexer.find_by(name: params[:lexer]).snippets
    end
    @lexers = Lexer.all
    @snippets = snippet_collection.page(params[:page])
    flash.now[:danger] = 'Cannot find any snippets.' if @snippets.blank?
  end

  def show
    @snippet = Snippet.find(params[:id])
  end

  def new
    @snippet = Snippet.new
    @lexers = Lexer.all
  end

  def create
    @snippet = current_user.snippets.build(snippet_params)
    if @snippet.save
      flash[:success] = 'Snippet created successfully.'
      redirect_to snippets_path
    else
      flash[:error] = "Couldn't create snippet."
      redirect_to new_snippet_path
    end
  end

  def edit
    @snippet = Snippet.find(params[:id])
    @lexers = Lexer.all
  end

  def update
    @snippet = Snippet.find(params[:id])
    if @snippet.update(snippet_params)
      flash[:success] = 'Snippet updated successfully.'
      redirect_to snippet_path(@snippet)
    else
      flash[:error] = "Couldn't update snippet."
      redirect_to edit_snippet_path(@snippet)
    end
  end

  def highlight_code_remote
    highlighted_code = view_context.highlight_code(params[:smelly_code], params[:lexer])
    render json: { highlighted_code: highlighted_code }
  end

  def check_lines_of_code
    render json: true
  end

  private

  def count_lines_of_code(code, lexer)
    #CodeRay.scan(code, lexer.downcase).loc
  end

  def snippet_params
    params.require(:snippet).permit(:title, :description, :smelly_body, :lexer_id)
  end

  def apply_filters(filters, snippets)
    filters.each do |filter|
      next if filter[1].blank?
      snippets = snippets.public_send(filter[0], filter[1])
    end
    snippets
  end

end
