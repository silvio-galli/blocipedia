require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { User.create!(user_name: "My Name", email: "myemail@example.com", password: "password") }
  it { is_expected.to have_many(:wikis) }
end
