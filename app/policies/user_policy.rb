class UserPolicy < ApplicationPolicy
  def is_premium?
    user.premium?
  end
end
