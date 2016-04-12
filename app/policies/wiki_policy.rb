class WikiPolicy < ApplicationPolicy

=begin
  def admin_or_owner?
    user.admin? or record.user == @user
  end

  def admin_or_owner_or_collaborator?
    admin_or_owner? || record.users.include?(@user)
  end
=end

  def show?
    (user.present? && record.private != true) ||
    (record.private && (record.users.include?(user) || record.user == user || user.admin?))
  end

  def edit?
    user.admin? || record.user == user || record.users.include?(user)
  end

  def update?
    edit?
  end

  def destroy?
    user.admin? || record.user == user
  end

  def can_add_collaborators?
    record.user == user && record.private? && user.premium?
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      wikis = []
      if user == nil
        all_wikis = scope.all
        wikis = []
        all_wikis.each do |wiki|
          if !wiki.private?
            wikis << wiki
          end
        end
      elsif user.role == 'admin'
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
          if !wiki.private? || wiki.users.include?(user)
            wikis << wiki
          end
        end
      end
      wikis
    end
  end
end
