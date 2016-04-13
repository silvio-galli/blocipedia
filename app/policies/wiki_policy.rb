class WikiPolicy < ApplicationPolicy
  def admin_or_owner?
    user.admin? || record.user == @user
  end

  def admin_or_owner_or_collaborator?
    admin_or_owner? || wiki.users.include?(@user)
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
          if !wiki.private? || wiki.user == user || wiki.users.include?(user)
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
