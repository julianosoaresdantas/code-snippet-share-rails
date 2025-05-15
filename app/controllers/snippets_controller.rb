class SnippetsController < ApplicationController
  include Pundit

  before_action :authenticate_user!, except: [ :index, :show ]
  before_action :set_snippet, only: [ :show, :edit, :update, :destroy ]
  after_action :verify_authorized, except: [ :index, :new, :create ]
  after_action :verify_policy_scoped, only: :index

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def index
    @snippets = policy_scope(Snippet).order(created_at: :desc)
    @test_model = TestModel.first
  end

  def show
  end

  def new
    @snippet = current_user.snippets.new
    authorize @snippet
  end

  def create
    @snippet = current_user.snippets.new(snippet_params)
    authorize @snippet # Authorize before saving
    if @snippet.save
      # @snippet.save_tags
      redirect_to @snippet, notice: "Snippet was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @snippet.update(snippet_params)
      @snippet.save_tags
      redirect_to @snippet, notice: "Snippet was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @snippet = @snippet # Already set by before_action
    authorize @snippet
    @snippet.destroy
    redirect_to snippets_path, notice: "Snippet was successfully deleted."
  end

  private

  def set_snippet
    @snippet = Snippet.find(params[:id])
    authorize @snippet # Authorize after finding the record
  end

  def snippet_params
    params.require(:snippet).permit(:title, :language, :code, :description, :privacy, :tag_list)
  end

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(request.referrer || root_path)
  end
end
