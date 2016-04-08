class WikiPolicy < ApplicationPolicy
  def admin_or_owner?
    user.admin? or record.user == @user
  end

  def admin_or_owner_or_collaborator?
    wiki_collaborators = record.collaborators.pluck(:user_id)
    user.admin? or record.user == @user or wiki_collaborators.include?(@user.id)
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      wikis = []
      if user.role == 'admin'
        wikis = scope.all
      elsif user.role == 'premium'
        all_wikis = scope.all
        all_wikis.each do |wiki|
          wiki_collaborators = wiki.collaborators.pluck(:user_id)
          if !wiki.private? || wiki.user == user || wiki_collaborators.include?(user.id)
            wikis << wiki
          end
        end
      else
        all_wikis = scope.all
        wikis = []
        all_wikis.each do |wiki|
          wiki_collaborators = wiki.collaborators.pluck(:user_id)
          if !wiki.private? || wiki_collaborators.include?(user.id)
            wikis << wiki
          end
        end
      end
      wikis
    end
  end
end
