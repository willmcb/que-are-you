Rails.application.routes.draw do
  resources :associations
  root :to => 'users#index'

  # sign up
  get 'users/new' => 'users#new', as: 'new_user'
	post 'users' => 'users#create'

  # log in:
	get '/login' => 'sessions#new', as: 'login_path'

	# create (post) action for when log in form is submitted:
	post '/login' => 'sessions#create'

	# log out:
	delete '/logout' => 'sessions#destroy'

  # user profile page show
  get 'users/:id' => 'users#show', as: 'user_profile'

  # users edit profile page
  get 'users/:id/edit' => 'users#edit', as: 'edit_profile'
  post 'users/:id/update' => 'users#update', as: 'update_profile'

  # routes for google authentication
  get 'auth/google_oauth2', to: redirect('/auth/google_oauth2'), as: 'google_login'
  get 'auth/:provider/callback', to: 'sessions#googleAuth'
  get 'auth/failure', to: redirect('/')

end
