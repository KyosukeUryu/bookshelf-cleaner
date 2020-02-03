require 'rails_helper'

RSpec.describe Message, type: :model do
  let(:user_a) { FactoryBot.create(:user) }
  let(:user_b) { FactoryBot.create(:user, email: 'b@example.com') }
  let(:conversation_a) { FactoryBot.create(:conversation, sender: user_a, recipient: user_b) }
  let(:message_a) { FactoryBot.create(:message, user: user_a, conversation: conversation_a) }

  it 'bodyが空ならバリデーションが通らない' do
    message_a.body = ''
    expect(message_a).to be_invalid
  end

  it '問題なく入力されれば登録される' do
    expect(message_a).to be_valid
  end
end

