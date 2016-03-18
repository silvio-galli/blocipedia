class SubscriptionsController < ApplicationController

  def create
    @subsrciption = Subscription.new(subscription_params)
    @subscription.user = current_user
  end

  def destroy
  end

  private

  def subscription_params
    params.require(:subscription).permit(:premium)
  end
end
