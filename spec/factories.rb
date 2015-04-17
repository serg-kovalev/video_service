FactoryGirl.define do
  factory :video do
    sequence(:link) { |n| "https://www.youtube.com/watch?v=v8h-#{n}AY5byU" }
    sequence(:uid) { |n| "#{n}" }
    sequence(:title) { |n| "title #{n}" }
    likes 1
    dislikes 0
    published_at Time.now
    association :user, factory: :user
  end

  factory :user do
    sequence(:name) { |n| "first last #{n}" }
    sequence(:email) {|n| "name@at#{n}.com"}
    password  "ttttesting"
    password_confirmation  "ttttesting"
    sequence(:username) { |n| "username#{n}" }
  end

  factory :authorization do
    sequence(:uid) { |n| "111#{n}" }
    provider 'none'
    token '111111aaaa2222'
    secret 'bbbsss32fsdf'
  end

  factory :facebook_auth, parent: :authorization do
    provider 'facebook'
  end

  factory :google_oauth2, parent: :authorization do
    provider 'google_oauth2'
  end
end
