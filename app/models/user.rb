class User < ActiveRecord::Base
  has_many :wikis, dependent: :destroy
  has_many :subscriptions, dependent: :destroy
  has_many :collaborators
  has_many :wiki_collaborations, through: :collaborators, source: :wiki

  after_initialize { self.role ||= :free }

  enum role: [:free, :premium, :admin]

  #scope :users_list, ->(user) { where('id != ?', user.id) }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

 def update_role_based_on_subscription
   if self.subscriptions != [] && self.subscriptions.last.premium
     self.update(role: :premium)
   elsif self.subscriptions == [] || self.subscriptions.last.premium == false
     self.update(role: :free)
   end
 end

 def update_private_wikis_after_downgrade
   self.wikis.each do |wiki|
     if wiki.private
       wiki.update(private: false)
     end
   end
 end

end
