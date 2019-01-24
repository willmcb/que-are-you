def login
  visit '/login'
  fill_in 'Email', with: @test_user.email
  fill_in 'Password', with: 'password'
  click_button 'Log in'
end

def signup
  visit '/users/new'
  fill_in 'Firstname', with: 'one'
  fill_in 'Lastname', with: 'two'
  fill_in 'Email', with: 'one@one.com'
  fill_in 'Password', with: 'password'
  fill_in 'Password confirmation', with: 'password'
  click_button 'Sign up'
end
