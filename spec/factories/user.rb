include ActionDispatch::TestProcess

FactoryBot.define do
  factory :user do
    firstname { "testuser" }
    lastname { "testlastname" }
    avatar { fixture_file_upload(Rails.root.join('spec','support','assets','Default_profile_image.jpg'), "image/jpg") }
    company_name { "superglobalmegacorp" }
    job_title { "tech worker" }
    biography { "Phasellus at porttitor enim, at accumsan ipsum. Integer eget justo" \
                " at nulla pulvinar accumsan. Sed suscipit arcu quis vestibulum pharetra. " \
                "Sed interdum ac metus a vehicula." }
    email { "testuser@test.com" }
    password { "password" }
    password_confirmation { "password" }
  end
end
