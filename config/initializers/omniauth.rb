Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV['GOOGLE_CLIENT_ID'], ENV['GOOGLE_CLIENT_SECRET'],
           :scope => 'userinfo.email, calendar, https://www.googleapis.com/auth/calendar, https://www.googleapis.com/auth/calendar.readonly',
           :skip_jwt => true
end
