begin
  User.create!(name:  "Toan",
               email: "toan@toan.com",
               password:              "foobar",
               password_confirmation: "foobar",
               admin: true,
               activated: true,
               activated_at: Time.zone.now)
rescue
  nil
end

100.times do |n|
  begin
    name  = Faker::Name.name
    email_name = name.split(" ")[1]
    email = "#{email_name}@gmail.com"
    password = "password"
    User.create!(name:  name,
                 email: email,
                 password:              password,
                 password_confirmation: password,
                 activated: true,
                 activated_at: Time.zone.now)
  rescue
    email_name += n.to_s
    email = "#{email_name}@gmail.com"
    User.create!(name:  name,
                 email: email,
                 password:              password,
                 password_confirmation: password,
                 activated: true,
                 activated_at: Time.zone.now)
  end
end