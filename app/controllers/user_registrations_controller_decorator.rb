UserRegistrationsController.class_eval do

  after_filter :claim_unclaimed, :only => :create, :if => Spree::ClaimOrder::Config[:require_email_confirmation]
  after_filter :unclaimed_orders_flash, :only => :create

  private

  def unclaimed_orders_flash
    if @user.confirmation_token and @user.unclaimed_orders.present?
      flash[:error] = t("instructions_sent_at_registration")
    end
  end

  def claim_unclaimed
    @user.claim_all_unclaimed_orders
  end

end