require 'rails_helper'

RSpec.describe User, type: :model do
  it 'nameが空ならバリデーションが通らない' do
    user = User.new(name: '', email: 'sample@hoge.com', password: 'password')
    expect(user).to be_invalid
  end

  it 'nameが４０文字を超えたらバリデーションが通らない' do
    name = 'a' * 41
    user = User.new(name: name, email: 'sample@hoge.com', password: 'password')
    expect(user).to be_invalid
  end

  it 'emailが空ならバリデーションが通らない' do
    user = User.new(name: 'sample', email: '', password: 'password')
    expect(user).to be_invalid
  end

  it 'emailが２５５文字を超えたらバリデーションが通らない' do
    email = 'a' * 255
    user = User.new(name: 'sample', email: "#{email}@hoge.com", password: 'password')
    expect(user).to be_invalid
  end

  it 'emailが正規表現に反していたらバリデーションが通らない' do
    user = User.new(name: 'sample', email: 'hogefuga', password: 'password')
    expect(user).to be_invalid
  end

  it 'passwordが空ならバリデーションが通らない' do
    user = User.new(name: 'sample', email: 'sample@hoge.com', password: '')
    expect(user).to be_invalid
  end

  it 'passwordが６文字未満ならバリデーションが通らない' do
    user = User.new(name: 'sample', email: 'sample@hoge.com', password: 'passw')
    expect(user).to be_invalid
  end

  it '各要素が入力され、nameが４０文字以内、emailが２５５文字以内、passwordが６文字以上、かつ
  emailが正規表現の通り入力されればバリデーションを通過する' do
    user = User.new(name: 'sample', email: 'sample@hoge.com', password: 'passwo')
    expect(user).to be_valid
  end
end

