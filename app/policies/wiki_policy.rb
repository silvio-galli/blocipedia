class WikiPolicy < ApplicationPolicy
  def admin_or_owner?
    user.admin? or record.user == @user
  end
end
