FactoryBot.define do
  factory :unread_book do
    title { 'hoge' }
    author { 'fuga' }
    status { 1 }
    reading_expired { Time.now + (60 * 60 * 24)}
    user
  end
end
