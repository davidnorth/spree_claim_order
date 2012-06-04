class Spree::UserConfirmationsController < Devise::ConfirmationsController

  helper 'spree/users', 'spree/base'
  ssl_required

  def create
    if current_user.confirmed?
      flash[:error] = t("already_confirmed")
    else
      current_user.send_confirmation_instructions
      flash[:notice] = t("instructions_sent_success")
    end
    redirect_to account_path
  end

  def show
    user = Spree::User.confirm_by_token(params[:confirmation_token])

    if user.errors.empty?
      flash[:notice] = t("account_confirmation_successful")
    else
      flash[:error] = t("invalid_token")
    end
    redirect_to account_path
  end

end
