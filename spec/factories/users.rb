FactoryBot.define do
  factory :user do
    email { 'test@hoge.com' }
    password { 'password' }
    confirmed_at { Date.today }
  end
end
