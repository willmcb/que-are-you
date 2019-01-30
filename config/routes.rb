Rails.application.routes.draw do
  resources :associations
  resources :messages
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
  get 'users/:id/event' => 'users#event', as: 'event'
  post 'users/:id/update_event' => 'users#update_event', as: 'update_event'

  # routes for google authentication
  get 'auth/google_oauth2', to: redirect('/auth/google_oauth2'), as: 'google_login'
  get 'auth/:provider/callback', to: 'sessions#google_auth'
  get 'auth/failure', to: redirect('/')

  # route for create message
  get 'users/:id/messages/new' => 'messages#new', as: 'message_associate'
end
