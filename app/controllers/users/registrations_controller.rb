module Users
  class RegistrationsController < Devise::RegistrationsController
    before_action :select_plan, only: :new
    # Extend default Devise gem behavior so that
    # if user signing up with Pro account (plan ID 2)
    # will be saved using special Stripe subscription function.
    # Otherwise Devise save user as usual.
    def create
      super do |resource|
        if params[:plan]
          resource.plan_id = params[:plan]
          if resource.plan_id == 2
            resource.save_with_subscription
          else
            resource.save
          end
        end
      end
    end

    private

    def select_plan
      return if params[:plan] == '1' || params[:plan] == '2'
      flash[:notice] = 'Please select a membership plan'
      redirect_to root_path
    end
  end
end
