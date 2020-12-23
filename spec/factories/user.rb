FactoryBot.define do
  factory :user1, class: User do
    name { "user1" }
    email { "user1@user1.com" }
    password { "user1user1" }
    password_confirmation { "user1user1" }
  end
  factory :user2, class: User do
    name { "user2" }
    email { "user2@user2.com" }
    password { "user2user2" }
    password_confirmation { "user2user2" }
  end
end
