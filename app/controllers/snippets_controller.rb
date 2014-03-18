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

  def create
    @snippet = current_user.snippets.build(snippet_params)
    @snippet.language_id = 1 #detect_source_language(@snippet.smelly_body)
    if @snippet.save
      flash[:success] = 'Snippet posted successfully.'
      redirect_to snippet_path(@snippet)
    else
      flash[:danger] = "Couldn't save snippet."
      redirect_to root_path
    end
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
    params.require(:snippet).permit(:title, :description, :smelly_body)
  end

end
