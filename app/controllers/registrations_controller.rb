class RegistrationsController < Devise::RegistrationsController
  before_action :authenticate_user!
  before_action :prevent_demo_users_to_edit, only: [:edit, :update]

  private
  def prevent_demo_users_to_edit
    if [
      "admin@example.com",
      "member@example.com",
      "premium@example.com"].include?(current_user.email)
      flash[:alert] = "Demo users cannot be modified! Please, sign up if you want an editable profile."
      redirect_to user_path(current_user)
    end
  end
end
