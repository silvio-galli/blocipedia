class ChargesController < ApplicationController

  def new
    @stripe_btn_data = {
      key: "#{ Rails.configuration.stripe[:publishable_key] }",
      description: "Premium Membership for #{current_user.email}",
      amount: Amount.default
    }
  end

  def create
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
      current_user.subscriptions.create(premium: true)
      current_user.update_role_based_on_subscription
    end
    flash[:notice] = "Thanks for your premium subscription, #{current_user.email}. Your plan was upgraded to #{current_user.role.capitalize}."
    redirect_to wikis_path
  end

  rescue Stripe::CardError => e
    flash.now[:alert] = e.message
    redirect_to new_charge_path

end
