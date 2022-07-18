require 'rails_helper'

RSpec.describe 'タスク管理機能', type: :system do
  let!(:task) { FactoryBot.create(:task, title: 'first_task', deadline: Date.today) }
  let!(:task2) {FactoryBot.create(:task, title: 'second_task', deadline: Date.today +1 ) }
        #FactoryBot.create(:task, title: "task", status:"done")
      #FactoryBot.create(:second_task, title: "sample", status:"not_yet")

  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        fill_in "task[title]", with: "タスク表示"
        fill_in "task[content]", with: "テストします"
        fill_in "task[deadline]", with: Date.today
        select "task[status]", with: "doing"
        click_on "Create タスク"
        expect(page).to have_content 'タスク表示'
      end
    end
  end
  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        visit tasks_path
        expect(page).to have_content 'first_task'
      end
    end
    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        visit tasks_path
        task_list = all('.task_row')[0]
        expect(page.text).to match 'first_task'
      end
    end
    context 'タスクが終了期限の降順に並んでいる場合'
      it '終了期限が近いタスクが一番上に表示される' do
        visit tasks_path
        task_list = all('.task_row')[0]
        expect(page.text).to match 'second_task'
      end
  end

  describe '詳細表示機能' do
     context '任意のタスク詳細画面に遷移した場合' do
       it '該当タスクの内容が表示される' do
        @task = FactoryBot.create(:task, title: 'first')
        visit task_path(@task.id)
        expect(page).to have_content 'first'
       end
     end
  end

  describe '検索機能' do
    before do
      FactoryBot.create(:task, title: "task", status: "done")
      FactoryBot.create(:second_task, title: "sample", status: "not_yet")
    end

    context 'タイトルであいまい検索をした場合' do
      it "検索キーワードを含むタスクで絞り込まれる" do
        visit tasks_path
        fill_in "task[title_search]", with: "task"
        click_button "検索"
        expect(page).to have_content 'task'
      end
    end
    context 'ステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        select "done", from: "task[status_search]"
        click_on '検索'
        expect(page).to have_content '完了'
      end
    end
    context 'タイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        fill_in "task[title_search]", with: "test_third"
        select "done", from: "search[status_search]"
        click_on '検索'
        expect(page).to have_content "test_third", "doing"
      end
    end
  end
end
