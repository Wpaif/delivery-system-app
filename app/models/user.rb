class User < ApplicationRecord
  belongs_to :carrier

  before_validation :set_carrier

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  private

  def set_carrier
    avaible_emails_domains = Carrier.where(enable: true).map(&:email_domain)
    user_email_domain = email.split('@').last

    if avaible_emails_domains.include?(user_email_domain)
      self.carrier_id = Carrier.find_by(email_domain: user_email_domain).id
    end
  end
end
