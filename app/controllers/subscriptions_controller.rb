require "active_merchant"

class SubscriptionsController < ApplicationController
 def index
 end

  def cancel
#    response = gateway.cancel_profile(paypal_profile_id, :note => 'Payment plan was canceled by user')
    flash[:notice] = 'You have successfully canceled your membership'
  end

 def error

 end

 # Confirmation step is the actual step that sends money.
  def complete
    token = params[:token]
    response = gateway.create_profile(token, :description => description, :start_date => start_date, :frequency => frequency_in_months, :amount => amount_in_dollars, :auto_bill_outstanding => true)
 
    # Save this profile_id in your transactions table.  This is used to cancel/modify the plan in the future.
    profile_id = response.params["profile_id"]
 
    if response.success?
      flash[:notice] = "Your PayPal account was successfully set up for the <strong>#{description}</strong> payment plan."
      redirect_to login_path
    else
      flash.now[:notice] = "There was a problem setting up your PayPal account for the <strong>#{description}</strong> payment plan"
      render cancel_url
    end
  end
  # The checkout method used to pass the values to paypal. The description is shown to the user in their paypal account.

def checkout
  setup_response = gateway.setup_authorization(100,
  :ip                => request.remote_ip,
  :return_url        => url_for(:action => 'process_payment'),
  :cancel_return_url => url_for(:action => 'cancel'),
  :description => "subscription"
  )
  redirect_to gateway.redirect_url_for(setup_response.token)
end

 def process_payment
  token = params[:token]
  # here we authorize the amount first before charging it
  authorize_response = gateway.authorize(MONEY_IN_CENTS,
  :ip       => request.remote_ip,
  :payer_id => params[:PayerID],
  :token    => params[:token]
  )

  if authorize_response.success?
  # period can be Day, Week, Month, Year, etc...
    profile_response = gateway.create_profile(params[:token],
    :description => 'subscription',
    :start_date => Date.today,
    :period => 'Month',
    :frequency => 1,
    :amount => "100",
    :auto_bill_outstanding => true)

    if profile_response.success?
     # capture the payment
      gateway.capture(money, authorize_response.authorization)
      # save paypal_profile_id to edit the subscription later
      # The profile_id is stored in: profile_response.params["profile_id"]
    else
      # void the transaction
      gateway.void(authorize_response.authorization)
    end
  end

end


private
#Here's the gateway info.
def gateway
   ActiveMerchant::Billing::Base.mode = :test

   @gateway ||= 
    ActiveMerchant::Billing::PaypalRecurringGateway.new(
     :login => 'nk_tes_1218714620_biz_api1.mail.ru',
     :password => '1218714626',
     :signature => 'An5ns1Kso7MWUdW4ErQKJJJ4qi4-A-b1ANj9g14qW6XOboBut7nnhDdn'
   )
   @gateway
 end



end
