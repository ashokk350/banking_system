require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_one(:account) }

  it { should validate_presence_of(:user_name) }
  it { should validate_presence_of(:email) }
end
