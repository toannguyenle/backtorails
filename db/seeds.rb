User.create!(name:  "Toan",
             email: "toan@toan.com",
             password:              "foobar",
             password_confirmation: "foobar",
             admin: true)

100.times do |n|
  name  = Faker::Name.name
  email_name = name.split(" ")[1]
  email = "#{email_name}@gmail.com"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password)
end