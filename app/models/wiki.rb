class Wiki < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: :slugged
  belongs_to :user
  has_many :collaborators, dependent: :destroy
  has_many :users, through: :collaborators
  validates :title, length: { minimum: 3, maximum: 100 }, presence: true
  validates :body, length: { minimum: 20 }, presence: true
  validates :user, presence: true

  default_scope { order('created_at DESC') }
end
