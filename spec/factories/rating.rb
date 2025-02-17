FactoryBot.define do
  factory :rating do
    value { (1..5).to_a.sample }
    association :post, strategy: :create
    association :user, strategy: :create
  end
end
