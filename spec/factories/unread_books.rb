FactoryBot.define do
  factory :unread_book do
    title { 'hoge' }
    author { 'fuga' }
    status { 0 }
    reading_expired { Time.now + (60 * 60 * 24)}
    user
  end
end
