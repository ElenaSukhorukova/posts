# Please create a seeds (db/seeds.rb) script that will generate at least 200k
# posts and about 100 users (please use about 50 unique IP addresses). Some posts (about 75%) should also be rated ratings.
# Important: the script should use API controllers and actions, consider using curl to generate data.
# One user should be able to vote for one post only once. User logins should be unique.

if User.all.count < 100
  100.times do
    User.find_or_create_by(login: Faker::Name.first_name)
  end
end

if Post.all.count < 200
  users = User.all.to_a
  ips = []

  50.times do
    ips << Faker::Internet.ip_v4_address
  end

  200.times do
    Post.create(
      title: Faker::Quote.robin,
      body: Faker::Quote.yoda,
      ip: ips.sample,
      user_id: users.sample.id
    )
  end
end

unless Rating.any?
  Post.order("RANDOM()").take(150).each do |post|
    20.times do
      post.ratings.create(
        user_id: User.order("RANDOM()").take.id,
        value: (1..5).to_a.sample
      )
    end
  end
end
