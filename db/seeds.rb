# Create a main sample user.
Baby.create!(name:  "Example User",
             email: "example@railstutorial.org",
             password:              "foobar",
             password_confirmation: "foobar",
             admin: true)

# Generate a bunch of additional users.
99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@protonmail.com"
  password = "password"
  Baby.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password)
end
