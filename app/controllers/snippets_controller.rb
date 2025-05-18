class SnippetsController < ApplicationController
  before_action :authenticate_user!, except: [ :index, :show ]
  before_action :set_snippet, only: [ :show, :edit, :update, :destroy ]

  def index
    @snippets = Snippet.order(created_at: :desc)
  end

  def show
    # @snippet is already set by the set_snippet before_action
  end

  def new
    @snippet = current_user.snippets.new
    @tags = Tag.all # Fetch all tags for the form
  end

  def create
    @snippet = current_user.snippets.new(snippet_params)
    if @snippet.save
      redirect_to @snippet, notice: "Snippet was successfully created."
    else
      @tags = Tag.all # Refetch tags for the form in case of error
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    # @snippet is already set by the set_snippet before_action
    @tags = Tag.all # Fetch all tags for the form
  end

  def update
    if @snippet.update(snippet_params)
      redirect_to @snippet, notice: "Snippet was successfully updated."
    else
      @tags = Tag.all # Refetch tags for the form in case of error
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @snippet.destroy
    redirect_to snippets_url, notice: "Snippet was successfully destroyed."
  end

  def my_snippets
    @my_snippets = current_user.snippets.order(created_at: :desc)
  end

  private

  def set_snippet
    @snippet = Snippet.find(params[:id])
    # Assuming you are using Pundit for authorization
    # authorize @snippet
  end

  def snippet_params
    params.require(:snippet).permit(:title, :language, :code, :description, :privacy, tag_ids: [])
  end
end
