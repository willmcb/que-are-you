FactoryBot.define do
  factory :user do
    firstname { "testuser" }
    lastname { "testlastname" }
    email { "testuser@test.com" }
    password { "password" }
    password_confirmation { "password" }
  end
end
