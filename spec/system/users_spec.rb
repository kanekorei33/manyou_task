require 'rails_helper'
RSpec.describe 'ユーザ管理テスト', type: :system do
  describe 'ユーザの新規登録ができること' do
    #context 'ユーザーを新規登録した場合' do
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
    #end
  end

  describe 'セッション機能のテスト' do
  let!(:user) { FactoryBot.create(:user) }
  let!(:user_second) { FactoryBot.create(:user_second) }
  let!(:task) { FactoryBot.create(:task, user: user) }
  before do
    visit new_session_path
    fill_in "session[email]", with: user.email
    fill_in "session[password]", with: user.password
    click_on "commit"
  end

  describe 'ログインができること' do
    context 'ログイン入力画面ですでにデータのあるユーザーが入力した場合' do
      it 'マイページに飛ぶ' do
        expect(page).to have_content '紅茶花伝'
      end
    end
  end
  describe '自分の詳細画面に飛べる事' do
    context 'ログイン済みのユーザーの場合' do
      it '詳細画面に飛べること' do
        visit tasks_path
        click_on 'Profile'
        expect(current_path).to eq user_path(user)
      end
    end
  end
  describe '一般ユーザが他人の詳細画面に飛ぶとタスク一覧画面に遷移すること' do
    context '他人の詳細画面に飛ぼうとする場合' do
      it 'タスク一覧画面に遷移すること' do
        click_on "Logout"
        fill_in 'session[email]', with: user_second.email
        fill_in 'session[password]', with: user_second.password
        click_on 'Log in'
        visit user_path(user)
        expect(current_path).to eq tasks_path
      end
    end
  end
  describe 'ログアウトができること' do
    context 'ログインユーザーがログアウトしたい場合' do
      it 'ログアウトできること' do
        click_on "Logout"
        expect(current_path).to eq new_session_path
      end
    end
  end
end
  describe '管理画面のテスト'do
  let!(:user_second) { FactoryBot.create(:user_second) }
  let!(:admin_user) { FactoryBot.create(:admin_user) }
  before do
    visit new_session_path
    fill_in 'session[email]', with: admin_user.email
    fill_in 'session[password]', with: admin_user.password
    click_on 'commit'
  end

  describe '管理ユーザは管理画面にアクセスできること' do
    context 'adminからログインした場合' do
      it '管理画面に移動する' do
        visit admin_users_path
      expect(current_path).to eq admin_users_path
      end
    end
  end
  describe '管理ユーザはユーザの新規登録ができること' do
    context '管理ユーザーがログインしている場合' do
      it 'ユーザーの新規登録が出来る' do
        visit new_admin_user_path
        fill_in 'user[name]', with: 'さくら'
        fill_in 'user[email]', with: 'sakura@gmail.com'
        fill_in 'user[password]', with: '123456'
        fill_in 'user[password_confirmation]', with: '123456'
        click_on '登録する'
        expect(page).to have_content "さくら"
      end
    end
  end

  describe '管理ユーザはユーザの詳細画面にアクセスできること' do
    context '管理ユーザーがログインしている場合' do
      it 'ユーザーの詳細画面へアクセスできる' do
        visit admin_user_path(user_second)
        expect(current_path).to include admin_user_path(user_second)
      end
    end
  end
  describe '管理ユーザはユーザの編集画面からユーザを編集できること' do
    context '管理ユーザーがログインしている場合' do
      it 'ユーザの編集画面からユーザを編集できる' do
        visit edit_admin_user_path(user_second)
        fill_in 'user_name', with: 'おーいお茶'
        fill_in 'user[password]', with: '123456'
        fill_in 'user[password_confirmation]', with: '123456'
        click_on 'commit'
        expect(page).to have_content 'おーいお茶'
      end
    end
  end
  describe '管理ユーザはユーザの削除をできること' do
    context '管理ユーザーがログインしている場合' do
      it 'ユーザの削除をできる' do
        visit admin_users_path
        click_on 'Destroy', match: :first
        page.accept_confirm
        expect(page).to have_content '消去しました'
      end
    end
  end
  describe '一般ユーザは管理画面にアクセスできないこと' do
    context '一般ユーザーがログインしている場合' do
      it '管理画面にアクセスできない' do
      visit new_session_path
      fill_in 'session[email]', with: 'upaupa@gmail.com'
      fill_in 'session[password]', with: '123456'
      click_on 'Log in'
      visit admin_users_path
      expect(page).to have_content '管理者以外はアクセスできません'
      end
    end
  end
  describe 'ユーザがログインせずタスク一覧画面に飛ぼうとしたとき、ログイン画面に遷移すること' do
    context 'ログインしていないユーザーが直接タスク一覧に飛ぼうとした場合' do
      it 'ログイン画面が表示される' do
        click_on "Logout"
        visit tasks_path
        expect(current_path).to eq new_session_path
      end
    end
  end
  end
end


