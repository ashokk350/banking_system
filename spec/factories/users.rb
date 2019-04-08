FactoryGirl.define do
  factory :user do
    user_name 'xyz'
    email 'example@gamil.com'
    role 'user'
    password '123456'
  end
end