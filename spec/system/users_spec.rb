require 'rails_helper'
RSpec.describe 'ユーザ管理テスト', type: :system do
  describe 'ユーザの新規登録ができること' do
    context 'ユーザーを新規登録した場合' do
      it 'タスク一覧が表示される' do
        visit new_user_path
        fill_in "user[name]", with: "テスト用ユーザー"
        fill_in "user[email]", with: "testuser@gmail.com"
        fill_in "user[password]", with: "111111"
        fill_in "user[password_confirmation]", with: "111111"
        click_on "commit"
        expect(page).to have_content "テスト用ユーザー"
        expect(page).to have_content "testuser@gmail.com"
      end
    end
  end
  before do
    visit_new_session_path
    fill_in "session[email]", with: "testuser@gmail.com"
    fill_in "session[password]", with: "111111"
    click_on "commit"
  end
  describe 'ユーザがログインせずタスク一覧画面に飛ぼうとしたとき、ログイン画面に遷移すること' do
    context 'ログインしていないユーザーが直接タスク一覧に飛ぼうとした場合' do
      it 'ログイン画面が表示される' do
        click_on "logout"
        visit tasks_path
        expect(current_path).to eq new_session_path
      end
    end
  end
end

RSpec.describe 'セッション機能のテスト', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @second_user = FactoryBot.create(:user_second)
  end

  describe 'ログインができること' do
    let!(:user_a) { FactoryBot.create(:user 'ユーザーa', email: 'a@gmail.com')}
    let(:user_b) { FactoryBot.create(:user 'ユーザーB', email: 'b@gmail.com')}
    let!(:user_a) { FactoryBot.create(:task, title: 'first_task', deadline: Date.today, user_a)}
    let!(:user_a) { FactoryBot.create(:task, title: 'second_task', deadline: Date.today+1, user_a)}
    before do

    context 'ログイン入力画面ですでにデータのあるユーザーが入力した場合' do
      it 'ログインができること' do
        visit_login_path
        fill_in 'メールアドレス', with: 'a@gmail.com'
        fill_in 'パスワード', with: '123456'
        click_on 'ログインする'
        expect(page).to have_content 'ユーザーa'
      end
    end
  end
  describe '自分の詳細画面に飛べる事' do
    context 'ログイン済みのユーザーの場合' do
      let(:login_user) { user_a }
    it '詳細画面に飛べること' do
      visit_show_task_path
      expect(page).to have_content 'first_task'
    end
  end
  describe '一般ユーザが他人の詳細画面に飛ぶとタスク一覧画面に遷移すること' do
    context '他人の詳細画面に飛ぼうとする場合' do
      it 'タスク一覧画面に遷移すること' do

      end
    end
  end
  describe 'ログアウトができること' do
    context 'ログインユーザーがログアウトしたい場合' do
      it 'ログアウトできること' do

      end
    end

  end
end
RSpec.describe '管理画面のテスト', type: :system do
  describe '管理ユーザは管理画面にアクセスできること' do
    context 'adminからログインした場合' do
      it '管理画面に移動する' do

      end
    end
  end
  describe '一般ユーザは管理画面にアクセスできないこと' do
    context '一般ユーザーがログインしている場合' do
      it '管理画面にアクセスできない' do

      end
    end
  end
describe '管理ユーザはユーザの新規登録ができること' do
  context '管理ユーザーがログインしている場合' do
    it 'ユーザーの新規登録が出来る' do

    end
  end

end
describe '管理ユーザはユーザの詳細画面にアクセスできること' do
  context '管理ユーザーがログインしている場合' do
    it 'ユーザーの詳細画面へアクセスできる' do

    end
  end
end
describe '管理ユーザはユーザの編集画面からユーザを編集できること' do
  context '管理ユーザーがログインしている場合' do
    it 'ユーザの編集画面からユーザを編集できる' do

    end
  end

end
describe '管理ユーザはユーザの削除をできること' do
  context '管理ユーザーがログインしている場合' do
    it 'ユーザの削除をできる' do
      
    end
  end
end



