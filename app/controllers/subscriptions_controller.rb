class SubscriptionsController < ApplicationController

  def create
    @subscription = Subscription.new(subscription_params)
    @subscription.user = current_user
  end

  def destroy
    @subscription = Subscription.find(params[:id])
    if @subscription.destroy
      flash[:notice] = "You've been downgraded to Free plan."
      redirect_to wikis_path
    else
      flash[:alert] = "You're request wasn't executed. Please try again or contact us."
      redirect_to wikis_path
    end
    current_user.update_role_based_on_subscription
  end

  private

  def subscription_params
    params.require(:subscription).permit(:premium)
  end
end
