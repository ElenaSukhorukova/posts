FactoryBot.define do
  factory :post do
    title { Faker::Quote.robin }
    body { Faker::Quote.yoda }
    ip { Faker::Internet.ip_v4_address }
    association :user, strategy: :create
  end

  factory :rated_post, :parent => :post do
    after(:create) do |post|
      (1..10).to_a.sample.times do
        post.ratings.create(user_id: create(:user).id, value: (1..5).to_a.sample )
      end
    end
  end
end
