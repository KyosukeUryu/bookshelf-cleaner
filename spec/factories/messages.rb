FactoryBot.define do
  factory :message do
    body { 'first message' }
    conversation
    user
  end
end
