FactoryBot.define do
  factory :finished_book do
    title { 'finished' }
    author { 'done auth' }
    status { 0 }
    text { 'good book' }
    user
  end
end
