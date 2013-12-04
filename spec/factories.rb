FactoryGirl.define do
  factory :user do
    sequence(:username) { |n| "Jane-#{n}" }
    email { "#{username}@example.com"}
    password "password"
    password_confirmation "password"
    is_admin false

    trait :is_admin do
      is_admin true
    end
  end

  factory :loan do
    sequence(:title) { |n| "Loan #{n}" }
    description "A loan description"
    business_name "The Business"
    amount 500
  end

  factory :comment do
    association :loan
    association :user

    text "These are words in a comment"
  end

  factory :bid do
    association :user
    association :loan
    amount 100
  end
end
