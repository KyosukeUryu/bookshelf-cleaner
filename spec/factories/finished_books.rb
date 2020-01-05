FactoryBot.define do
  factory :finished_book do
    title { 'finished' }
    author { 'done auth' }
    status { 0 }
    impression { 'good book' }
    user
  end
end
