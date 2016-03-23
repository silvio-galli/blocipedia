class SubscriptionsController < ApplicationController

  def new
    @subscription = Subscription.new
    @stripe_btn_data = {
      key: "#{ Rails.configuration.stripe[:publishable_key] }",
      description: "Premium Membership for #{current_user.email}",
      amount: Amount.default
    }
  end

  def create
    @subscription = Subscription.new(subscription_params)
    @subscription.user_id = current_user.id

    # Create a Stripe Customer object, for associating with the charge
    customer = Stripe::Customer.create(
      email: current_user.email,
      card: params[:stripeToken]
    )

    # Here's the charge
    charge = Stripe::Charge.create(
      customer: customer.id,
      amount: Amount.default,
      description: "Premium Membership for #{current_user.email}",
      currency: "usd"
    )
    if charge["status"] == "succeeded"
      @subscription.update(premium: true)
      current_user.update_role_based_on_subscription
    end
    flash[:notice] = "Thanks for your premium subscription, #{current_user.email}. Your plan was upgraded to #{current_user.role.capitalize}."
    redirect_to user_path(current_user)

    rescue Stripe::CardError => e
      flash.now[:alert] = e.message
      redirect_to new_charge_path
  end

  def destroy
    @subscription = Subscription.find(params[:id])
    if @subscription.destroy
      flash[:notice] = "You've been downgraded from Premium plan to Free plan. Now all your wikis are public."
      redirect_to user_path(current_user)
    else
      flash[:alert] = "You're request wasn't executed. Please try again or contact us."
      redirect_to user_path(current_user)
    end
    current_user.update_role_based_on_subscription
    current_user.update_private_wikis_after_downgrade
  end

  private

  def subscription_params
    params.require(:subscription).permit(:premium, :user_id)
  end
end
