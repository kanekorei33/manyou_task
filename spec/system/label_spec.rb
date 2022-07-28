require 'rails_helper'

RSpec.describe 'ラベル管理機能', type: :system do
  let!(:user) { FactoryBot.create(:user)}
  let!(:task) { FactoryBot.create(:task, user: user)}
  let!(:label) {FactoryBot.create(:label)}
  let!(:second_label) {FactoryBot.create(:second_label)}
  let!(:third_label) {FactoryBot.create(:third_label)}
before do
  visit new_session_path
  fill_in "session[email]", with: user.email
  fill_in "session[password]", with: user.password
  click_on "commit"
end
  context 'タスクを新規作成画面でラベルも複数登録できる' do
    it 'ラベルを複数登録できるかつ詳細画面で紐づいているラベル一覧が表示される' do
      visit new_task_path
      fill_in "task[title]", with: "タスク表示"
      fill_in "task[content]", with: "テストします"
      fill_in "task[deadline]", with: Date.today
      select "着手中", from: "task_status"
      check "test_label_1"
      check "test_label_2"
      click_on "commit"
      expect(page).to have_content "test_label_1"
      expect(page).to have_content "test_label_2"
      end
    end
    context 'ラベルの検索が出来る' do
      it '検索されたラベルが表示される' do
        visit new_task_path
        fill_in "task[title]", with: "タスク表示"
        fill_in "task[content]", with: "テストします"
        fill_in "task[deadline]", with: Date.today
        select "着手中", from: "task_status"
        check "test_label_2"
        click_on "Create タスク"
        visit tasks_path
        select "test_label_3", from:"label_id"
        click_on "commit"
        expect(page).to have_content "test_label_3"
      end
    end
  end
