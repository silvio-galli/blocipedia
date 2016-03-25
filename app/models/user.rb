class User < ActiveRecord::Base
  has_many :subscriptions, dependent: :destroy
  has_many :wikis, dependent: :destroy
  # pry(main)> User.last.wikis.to_sql
  # => "SELECT \"wikis\".* FROM \"wikis\" WHERE \"wikis\".\"user_id\" = 8  ORDER BY created_at DESC"

  has_many :collaborators
  has_many :wiki_collaborations, through: :collaborators, source: :wiki
  # pry(main)> User.last.wiki_collaborations.to_sql
  # => "SELECT \"wikis\".* FROM \"wikis\" INNER JOIN \"collaborators\" ON \"wikis\".\"id\" = \"collaborators\".\"wiki_id\" WHERE \"collaborators\".\"user_id\" = 8  ORDER BY created_at DESC"

  after_initialize { self.role ||= :free }

  enum role: [:free, :premium, :admin]

  scope :users_list, ->(user) { where('id != ?', user.id) }

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
