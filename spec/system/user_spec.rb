require 'rails_helper'

describe 'ユーザー設定機能', type: :system do
  let!(:user_a) { FactoryBot.create(:user, name: 'first_man', email: 'a@example.com') }

  describe 'ユーザー登録機能' do
    before do
      visit new_user_registration_path
      fill_in '名前', with: new_user_name
      fill_in 'メールアドレス', with: new_user_email
      fill_in 'パスワード', with: new_user_password
      fill_in '確認用パスワード', with: new_user_password
      click_button 'Sign up'
    end

    context 'ユーザー情報が正しく入力される' do
      let(:new_user_name) { 'Mr.sample' }
      let(:new_user_email) { 'example@sample.com' }
      let(:new_user_password) { 'sampleman' }
      it '確認用メールが送られる' do
        expect(page).to have_content '本人確認用のメールを送信しました。メール内のリンクからアカウントを有効化させてください。'
      end
    end

    context 'ユーザー情報が入力されない' do
      let(:new_user_name) { '' }
      let(:new_user_email) { '' }
      let(:new_user_password) { '' }
      it 'エラーメッセージが表示される' do
        expect(page).to have_content '3 件のエラーが発生したため ユーザー は保存されませんでした。'
      end
    end
  end

  describe 'ログイン機能' do
    before do
      visit new_user_session_path
      fill_in 'メールアドレス', with: user_email
      fill_in 'パスワード', with: user_password
      click_button 'Log in'
    end

    context '正しいログイン情報を入力する' do
      let(:user_email) { 'a@example.com' }
      let(:user_password) { 'password' }
      it 'ログインが完了する' do
        expect(page).to have_content 'ログインしました。'
      end
    end

    context '誤った情報を入力する' do
      let(:user_email) { 'a@example.com' }
      let(:user_password) { 'hogefuga' }
      it 'ログインに失敗する' do
        expect(page).to have_content 'メールアドレスまたはパスワードが違います。'
      end
    end
  end

  describe 'ユーザー情報編集機能' do
    before do
      visit new_user_session_path
      fill_in 'メールアドレス', with: login_user.email
      fill_in 'パスワード', with: login_user.password
      click_button 'Log in'
      visit edit_user_registration_path
      fill_in '名前', with: edit_user_name
      fill_in 'メールアドレス', with: edit_user_email
      fill_in '現在のパスワード', with: edit_user_password
      click_button 'Update'
    end

    let(:login_user) { user_a }

    context '変更情報を正しく入力する' do
      let(:edit_user_name) { 'hogefuga' }
      let(:edit_user_email) { 'c@example.com' }
      let(:edit_user_password) { 'password' }
      it 'ユーザー情報が更新される' do
        expect(page).to have_content 'アカウント情報を変更しました。'
      end
    end

    context '誤った情報を入力する' do
      let(:edit_user_name) { 'hogefuga' }
      let(:edit_user_email) { 'c@example.com' }
      let(:edit_user_password) { 'miss_pass' }
      it 'ログインに失敗する' do
        expect(page).to have_content '現在のパスワードは不正な値です'
      end
    end
  end
end


