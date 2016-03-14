require 'rails_helper'

RSpec.describe Wiki, type: :model do
  let (:user) { User.create!( user_name: "My Name", email: "email@example.com", password: "password", confirmation_token: "nUL2xBpinJyT7Yy8PEJK", confirmed_at: "2016-03-08 17:01:47" ) }
  let(:wiki) { user.wikis .create!( title: "This is the wiki title", body: "This is the wiki body This is the wiki body", private: false ) }

  it { should validate_presence_of(:title) }
  it { should validate_length_of(:title).is_at_least(3) }
  it { should validate_length_of(:title).is_at_most(100) }

  it { should validate_presence_of(:body) }
  it { should validate_length_of(:body).is_at_least(20) }

  it { should validate_presence_of(:user) }
  
  describe "attibutes" do
    it "should respond to title" do
      expect(wiki).to respond_to(:title)
    end
    it "should respond to body" do
      expect(wiki).to respond_to(:body)
    end
    it "should respond to private" do
      expect(wiki).to respond_to(:private)
    end
    it "private default value is false" do
      expect(wiki.private).to eq(false)
    end
  end
end
