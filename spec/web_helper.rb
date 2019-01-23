def login
  visit '/login'
  fill_in 'Email', with: @test_user.email
  fill_in 'Password', with: 'password'
  click_button 'Log in'
end
