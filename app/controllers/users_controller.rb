class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.friendly.find(params[:id])
    @users = User.all
  end

#  def downgrade
#    user = current_user
#    if user.premium?
#      user.update(role: :free)
#      flash[:notice] = "You successfully downgrade to Free Plan."
#      redirect_to wikis_path
#    else
#      flash.now[:alert] = "You cannot downgrade. You're not a Premium user."
#      redirect_to wikis_path
#    end
#  end

end
