FactoryBot.define do
  factory :user do
    name { "John" }
    email { "john@live.com" }
    password { "123456" }
    password_confirmation { "123456" }
  end
end
