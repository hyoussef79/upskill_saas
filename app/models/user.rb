class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :plan
  has_one :profile

  attr_accessor :stripe_card_token
  def save_with_subscription
    return unless valid?
    customer = Stripe::Customer.create(
      description: email,
      plan: plan_id,
      card: stripe_card_token
    )
    self.stripe_customer_token = customer.id
    save!
  end
end
