# メインのサンプルユーザーを1人作成する
User.create!(full_name:  "Example User",
             user_name:  "Example Man",
             email: "example@railstutorial.org",
             password:              "foobar",
             password_confirmation: "foobar",
             admin: true,
             activated: true,
             activated_at: Time.zone.now)

# 追加のユーザーをまとめて生成する
99.times do |n|
  full_name  = Faker::Name.name
  user_name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(full_name: full_name,
               user_name: user_name,
               email: email,
               password:              password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now)
end

# ユーザーの一部を対象にマイクロポストを生成する
users = User.order(:created_at).take(2)
2.times do
  content = Faker::Lorem.sentence(word_count: 5)
  users.each { |user| user.microposts.create!(content: content) }
  microposts = Micropost.all
  microposts.each { |micropost| micropost.image.attach(io: File.open('app/assets/images/sample_photo.jpg'), filename: 'sample_photo.jpg')}
end


# 以下のリレーションシップを作成する
users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }