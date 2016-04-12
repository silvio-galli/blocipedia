class CollaboratorsController < ApplicationController

  def create
    collaborator = Collaborator.new
    collaborator.user_id = params[:user_id]
    collaborator.wiki_id = params[:wiki_id]

    if collaborator.save
      flash[:notice] = "Collaborator was successfully added"
      redirect_to edit_wiki_path(collaborator.wiki_id)
    else
      flash[:alert] = "No collaborator added"
      redirect_to edit_wiki_path(collaborator.wiki_id)
    end
  end

  def destroy
    @wiki = Wiki.find(params[:wiki_id])
    collaborator = Collaborator.find_by(user_id: params[:user_id], wiki_id: @wiki.id)
    if collaborator.destroy
      flash[:notice] = 'Collaborator removed'
    else
      flash[:alert] = 'There was an error, please try again'
    end
    redirect_to edit_wiki_path()
  end

end
