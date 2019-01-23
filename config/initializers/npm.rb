Rails.application.configure do
  system 'npm install' if Rails.env.development? || Rails.env.test?
end
