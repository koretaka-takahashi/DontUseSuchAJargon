FactoryBot.define do
  factory :user1, class: User do
    name { "user1" }
    email { "user1@user1.com" }
    password { "user1user1" }
    password_confirmation { "user1user1" }
  end
end
