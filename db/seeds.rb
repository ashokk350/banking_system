User.create!(email: 'manager@bank.com') do |u|
  u.user_name = 'Manager'
  u.password = '123456'
  u.password_confirmation = '123456'
  u.role = User.roles[:manager]
end