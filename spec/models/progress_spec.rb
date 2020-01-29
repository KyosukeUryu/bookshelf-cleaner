require 'rails_helper'

RSpec.describe Message, type: :model do
  let(:user_a) { FactoryBot.create(:user) }
  let(:progress_a) { FactoryBot.create(:progress, user: user_a) }

  it 'contentが空ならバリデーションが通らない' do
    progress_a.content = ''
    expect(progress_a).to be_invalid
  end

  it '問題なく入力されれば登録される' do
    expect(progress_a).to be_valid
  end
end


