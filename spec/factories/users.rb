FactoryBot.define do
  factory :user do
    name { "MyString" }
    email { "hoge@example.com" }
    password { "foobar" }
  end
end
