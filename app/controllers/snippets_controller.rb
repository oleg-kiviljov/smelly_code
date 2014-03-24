class SnippetsController < ApplicationController

  before_action :authenticate_user!, except: [:index, :show]

  def index
    snippet_collection = Snippet.all.includes(:language)
    snippet_collection = Language.find_by(name: params[:language]).snippets if params[:language]
    @snippets = snippet_collection.page(params[:page])
  end

  def show
    @snippet = Snippet.find(params[:id])
  end

  def new
    @snippet = Snippet.new
    @languages = Language.all
  end

  def create
    @snippet = current_user.snippets.build(snippet_params)
    if @snippet.save
      flash[:success] = 'Snippet added successfully.'
      redirect_to snippets_path
    else
      flash[:error] = "Couldn't add snippet."
      redirect_to new_snippet_path
    end
  end

  def edit
    @snippet = Snippet.find(params[:id])
    @languages = Language.all
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

  def highlight_code
    snippet_decorator = SnippetDecorator.new(Snippet.new)
    highlighted_code = snippet_decorator.highlight_code(params[:smelly_code], params[:language])
    render json: { highlighted_code: highlighted_code }
  end

  def check_lines_of_code
    code = params[:snippet][:smelly_body]
    language = params[:language]
    render json: count_lines_of_code(code, language) < 15
  end

  private

  def count_lines_of_code(code, language)
    CodeRay.scan(code, language).loc
  end

  def snippet_params
    params.require(:snippet).permit(:title, :description, :smelly_body, :language_id)
  end

end
