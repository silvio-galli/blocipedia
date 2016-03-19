class User < ActiveRecord::Base
  has_many :wikis, dependent: :destroy
  has_many :subscriptions, dependent: :destroy
  after_initialize { self.role ||= :free }

  enum role: [:free, :premium, :admin]
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

 def update_role_based_on_subscription
   unless self.subscriptions == []
     self.update(role: :premium)
   else
     self.update(role: :free)
   end
 end
end
