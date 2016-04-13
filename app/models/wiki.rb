class Wiki < ActiveRecord::Base
  belongs_to :user
  has_many :collaborators, dependent: :destroy
  has_many :users, through: :collaborators
  validates :title, length: { minimum: 3, maximum: 100 }, presence: true
  validates :body, length: { minimum: 20 }, presence: true
  validates :user, presence: true

  def owner
    user
  end

  default_scope { order('created_at DESC') }
end
