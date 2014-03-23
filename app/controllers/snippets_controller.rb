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
      # render errors here
      redirect_to root_path
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
      #render errors here
    end
  end

  def highlight_code
    snippet_decorator = SnippetDecorator.new(Snippet.new)
    highlighted_code = snippet_decorator.highlight_code(params[:smelly_code], params[:language])
    render json: { highlighted_code: highlighted_code }
  end

  private

  def detect_source_language(code)
    code_to_identify = (<<-EOT)
      "#{code}"
    EOT
    source_classifier = SourceClassifier.new
    language = source_classifier.identify(code_to_identify)
    Language.find_by(name: language).id
  end

  def snippet_params
    params.require(:snippet).permit(:title, :description, :smelly_body, :language_id)
  end

end
