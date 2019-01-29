# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database
# with its default values.
# The data can then be loaded with the rails db:seed command (or created
# alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' },
# { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create(email: 'test@user.com', firstname: 'Alex', lastname: 'Newton', )
User.create(email: 'test2@user.com', firstname: 'David', lastname: 'Gisbey', )
User.create(email: 'test3@user.com', firstname: 'Will', lastname: 'Mcbrien', )
Association.create(user_id: 1, associate_id: 2, longitude: 53.477370, latitude: -2.245035)
Association.create(user_id: 2, associate_id: 1, longitude: 53.477370, latitude: -2.245035)
Association.create(user_id: 1, associate_id: 3, longitude: 52.244760, latitude: 0.715621)
Association.create(user_id: 3, associate_id: 1, longitude: 52.244760, latitude: 0.715621)
