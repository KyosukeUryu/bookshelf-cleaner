FactoryBot.define do
  factory :comment do
    content { 'test-comment' }
    user
    finished_book
  end
end
