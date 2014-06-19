def sign_in_user(user)
  visit root_url
  fill_in 'user[email]', with: user.email
  fill_in 'user[password]', with: user.password
  click_on 'Log In'
end
