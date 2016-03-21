class WikisController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @wikis = Wiki.all
  end

  def new
    @wiki = Wiki.new
  end

  def create
    @wiki = Wiki.new(wiki_params)
    @wiki.user = current_user

    if @wiki.save
      flash[:notice] = "Wiki was successfully saved"
      redirect_to wiki_path(@wiki.id)
    else
      flash[:alert] = "Wiki was not saved. Please try again."
      render :new
    end
  end

  def show
    @wiki = Wiki.find(params[:id])
    if @wiki.private && user_signed_in?
      authorize @wiki, :admin_or_owner?
    end
    
    renderer = Redcarpet::Render::HTML
    @markdown = Redcarpet::Markdown.new(renderer, extensions = {})
  end

  def edit
    @wiki = Wiki.find(params[:id])
    authorize @wiki, :admin_or_owner?

    renderer = Redcarpet::Render::HTML
    @markdown = Redcarpet::Markdown.new(renderer, extensions = {})
  end

  def update
    @wiki = Wiki.find(params[:id])
    @wiki.assign_attributes(wiki_params)

    if @wiki.save
      flash[:notice] = "Wiki was successfully saved."
      redirect_to wiki_path(@wiki.id)
    else
      flash[:alert] = "Wiki was not saved. Try again."
      render :edit
    end
  end

  def destroy
    @wiki = Wiki.find(params[:id])
    authorize @wiki, :admin_or_owner?
    if @wiki.destroy
      flash[:notice] = "Wiki #{@wiki.id} was deleted."
      redirect_to wikis_path
    else
      flash[:alert] = "Wiki was not deleted."
      render :show
    end
  end

  private

  def wiki_params
    params.require(:wiki).permit(:title, :body, :private)
  end
end
